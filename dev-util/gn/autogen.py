#!/usr/bin/env python3

import re
import shutil
import pathlib
import textwrap
from metatools.cmd import run_shell, capture_bg


async def generate(hub, **pkginfo):
	clone_dir = pathlib.Path(hub.pkgtools.model.temp_path, "gn_clone")
	try:
		clone_dir.mkdir(parents=True, exist_ok=True)

		await run_shell(f"git clone https://gn.googlesource.com/gn {clone_dir}")

		root_tag = "initial-commit"

		proc, output = await capture_bg(
			f"(cd {clone_dir}; git describe HEAD --abbrev=12 --match {root_tag})"
		)
		if proc.returncode != 0:
			raise hub.pkgtools.ebuild.BreezyError(
				f"Failed to describe Git HEAD: command exited with code {proc.returncode}: {output}"
			)

		described_ref = output.strip()
		ref_pattern = re.compile(f"^{root_tag}-(\d+)-g([0-9a-f]+)")

		ref_match = ref_pattern.match(described_ref)
		if ref_match is None:
			raise hub.pkgtools.ebuild.BreezyError(
				f"Described ref {described_ref} has an unexpected structure"
			)

		(position_num, position) = ref_match.groups()

		version = f"0.{position_num}"

		src_dir = f"gn-{version}"
		src_archive_name = f"{src_dir}.tar.xz"

		src_archive, metadata = hub.Archive.find_by_name(src_archive_name)
		if src_archive is None:
			src_archive = hub.Archive(src_archive_name)
			await src_archive.initialize(src_dir)

			shutil.copytree(
				clone_dir, pathlib.Path(src_archive.top_path), dirs_exist_ok=True
			)

			shutil.rmtree(pathlib.Path(src_archive.top_path, ".git"))

			out_path = pathlib.Path(
				src_archive.top_path,
				"out",
			)
			out_path.mkdir(parents=True, exist_ok=True)

			last_commit_header_path = out_path / "last_commit_position.h"
			last_commit_header_path.write_text(
				textwrap.dedent(f"""\
					#ifndef OUT_LAST_COMMIT_POSITION_H_
					#define OUT_LAST_COMMIT_POSITION_H_

					#define LAST_COMMIT_POSITION_NUM {position_num}
					#define LAST_COMMIT_POSITION "{position_num} ({position})"

					#endif	// OUT_LAST_COMMIT_POSITION_H_
				""")
			)

			await src_archive.store_by_name()

		ebuild = hub.pkgtools.ebuild.BreezyBuild(
			**pkginfo,
			version=version,
			src_dir=src_dir,
			artifacts=[src_archive],
		)
		ebuild.push()
	finally:
		shutil.rmtree(clone_dir)

