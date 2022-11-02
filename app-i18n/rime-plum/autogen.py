#!/usr/bin/env python3
# NOTE: If plum 1.0 releases, switch to release based autogen
from datetime import datetime, timedelta

github_user = "rime"
github_repo = "rime"

async def query_github_api(user, repo, query):
    return await hub.pkgtools.fetch.get_page(
        f"https://api.github.com/repos/{user}/{repo}/{query}",
        is_json=True,
        refresh_interval=timedelta(days=15),
    )

async def is_valid(user, repo, commit):
    commit_sha = commit["sha"]
    commit_status = await query_github_api(user, repo, f"commits/{commit_sha}/status")

    return "failure" not in commit_status["state"]

# Generates a link from a name
async def process_pkg(pkg, hub, **pkginfo):
    commits = await query_github_api(github_user, f"{github_repo}-{pkg}", "commits?sha=master")
    valid_commits = (
        commit for commit in commits if await is_valid(github_user, f"{github_repo}-{pkg}", commit)
    )
    target_commit = await valid_commits.__anext__()
    commit_hash = target_commit["sha"]

    return f"https://github.com/{github_user}/{github_repo}-{pkg}/archive/{commit_hash}.tar.gz"

# This function fetches the initial package list from the plum repository and parses it to return a list of packages
async def get_pkgs():
    package_list = await hub.pkgtools.fetch.get_page("https://raw.githubusercontent.com/rime/plum/master/preset-packages.conf", is_json=False, refresh_interval=timedelta(days=15))

    package_list = package_list.replace(" ", "").replace("\t", "")
    # find the first occurance of ( and erase 2 additional characters(\r\n) to remove the space,
    # resulting in a nice string to iterate over line by line until we find the ) terminator
    package_list = package_list[package_list.find('(') + 2:]

    packages = []
    accum = ""
    for pkg in package_list:
        if pkg == '\n':
            packages.append(accum)
            accum = ""
        elif pkg == ')':
            break
        else:
            accum += pkg

    return packages

async def generate(hub, **pkginfo):
    commits = await query_github_api(github_user, "plum", "commits?sha=master")

    valid_commits = (
        commit for commit in commits if await is_valid(github_user, "plum", commit)
    )

    target_commit = await valid_commits.__anext__()

    commit_date = datetime.strptime(
        target_commit["commit"]["committer"]["date"], "%Y-%m-%dT%H:%M:%SZ"
    )
    commit_hash = target_commit["sha"]
    version = commit_date.strftime("%Y%m%d")
    final_name = f"{pkginfo['name']}-{version}.tar.gz"
    url = f"https://github.com/{github_user}/plum/archive/{commit_hash}.tar.gz"

    artifacts = [ hub.pkgtools.ebuild.Artifact(url=url, final_name=final_name)]

    packages = await get_pkgs()
    # Process the package to get a link, alias the artifact using ebuild formatting to get a human-readable name
    for pkg in packages:
        artifacts.append(hub.pkgtools.ebuild.Artifact(await process_pkg(pkg, hub, **pkginfo), final_name=f"{pkg}.tar.gz"))

    ebuild = hub.pkgtools.ebuild.BreezyBuild(
        **pkginfo,
        github_user=github_user,
        github_repo="plum",
        version=version,
        pkgs=packages,
        artifacts=artifacts,
    )
    ebuild.push()

