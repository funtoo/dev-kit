#!/usr/bin/env python3

from datetime import datetime


async def build_artifact_from_commit(plugin, github_user, github_repo):
    commits_url = f"https://api.github.com/repos/{github_user}/{plugin}/commits"

    if github_repo: repo_url = f"/{github_repo}"
    else: repo_url = ''

    commit = await hub.pkgtools.fetch.get_page(
        commits_url + repo_url,
        is_json=True,
    )

    # If we have received multiple commits, we want the most recent one which should be first
    if(type(commit) == list): commit = commit[0]

    # Now we can get the necessary data we need
    sha = commit["sha"]
    url = f"https://github.com/{github_user}/{plugin}/tarball/{sha}"

    commit_date = datetime.strptime(commit["commit"]["committer"]["date"], "%Y-%m-%dT%H:%M:%SZ")
    version = commit_date.strftime("%Y%m%d")

    if github_repo:
        tarball_name = f"{github_repo}-{plugin}-{version}-{sha[:7]}.tar.gz"
    else:
        tarball_name = f"{plugin}-{version}-{sha[:7]}.tar.gz"

    return hub.pkgtools.ebuild.Artifact(url=url, final_name=tarball_name)


async def generate(hub, **pkginfo):
    github_user = "radareorg"
    github_repo = pkginfo["name"]
    artifacts = {}

    pkgmetadata = await hub.pkgtools.fetch.get_page(
        f"https://api.github.com/repos/{github_user}/{github_repo}",
        is_json=True,
    )
    description = pkgmetadata["description"]

    newpkginfo = await hub.pkgtools.github.release_gen(hub, github_user, github_repo)
    artifacts = [(github_repo, newpkginfo["artifacts"][0])]

    # aarch64 architecture plugins
    plugins = ["vector35-arch-arm64", "vector35-arch-armv7"]

    for plugin in plugins:
        artifacts.append((plugin, await build_artifact_from_commit(plugin, github_user, github_repo)))

    # testbins
    artifacts.append((
        "USE:test",
        await build_artifact_from_commit(github_repo + "-testbins", github_user, '')
    ))

    print([a[1].final_name for a in artifacts])

    ebuild = hub.pkgtools.ebuild.BreezyBuild(
        **pkginfo,
        github_user=github_user,
        github_repo=github_repo,
        description=description,
        version=newpkginfo['version'],
        artifacts=dict(artifacts),
    )
    ebuild.push()
