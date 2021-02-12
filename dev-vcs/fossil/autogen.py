#!/usr/bin/env python3

import re
from pathlib import Path
from collections import namedtuple
import jinja2


class Option(namedtuple("Opt", ("use", "code", "description", "is_default"))):
	@property
	def iuse(self):
		return ("+" if self.is_default else "-") + self.use


def use_from_option(option):
	return re.sub("^(with-|fossil-)", "", option)


def get_options_from_autodef(auto_def_data):
	for option, description in re.findall(r"(\S+)\W+=>\W+\{(.*)\}", auto_def_data, flags=re.MULTILINE):
		option, *value = re.split("=|:", option)
		value = value[0] if value else None
		use = use_from_option(option)
		if value == "":
			print(f"skipping {option}")
			continue
		if value in ("0", "1", None):
			code = f"--{option}=$(usex {use} 1 0)"
			is_default = value == "1"
		else:
			value = value.split("|")
			if "auto" in value and "none" in value:
				code = f"--{option}=$(usex {use} 1 none)"
			elif value == ["path"]:
				code = f"--{option}=$(usex {use} 1 0)"
			else:
				code = f'$(usex {use} "--{option}=1" "")'
			is_default = True

		yield Option(use, code, description, is_default)


async def generate(hub, **pkginfo):
	uv_files = await hub.pkgtools.fetch.get_page("https://fossil-scm.org/home/juvlist", is_json=True)
	versions = []
	for item in uv_files:
		match = re.match(r"fossil-src-([\d\.]+).tar.gz", item["name"])
		if match:
			versions.append((match.group(1), item["name"]))
	version, filename = max(versions, key=lambda item: tuple(map(int, item[0].split("."))))
	url = f"http://www.fossil-scm.org/index.html/uv/{filename}"
	artifact = hub.pkgtools.ebuild.Artifact(url=url)
	await artifact.fetch()
	artifact.extract()
	auto_def_path = next(Path(artifact.extract_path).iterdir()) / "auto.def"
	with auto_def_path.open() as f:
		auto_def_data = f.read()
	options = list(get_options_from_autodef(auto_def_data))
	artifact.cleanup()
	ebuild = hub.pkgtools.ebuild.BreezyBuild(
		**pkginfo,
		version=version,
		codes=[opt.code for opt in options],
		iuses=[opt.iuse for opt in options],
		options=options,
		artifacts=[artifact],
	)
	ebuild.push()
	with (Path(ebuild.template_path) / "metadata.tmpl").open() as tempf:
		template = jinja2.Template(tempf.read())
	with (Path(ebuild.output_pkgdir) / "metadata.xml").open("w") as metaf:
		metaf.write(template.render(options=options))
