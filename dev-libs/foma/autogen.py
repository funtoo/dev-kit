#!/usr/bin/env python3
# TODO: Replace with commit based autogen when the generator gets released
from datetime import datetime, timedelta

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


async def get_latest_commit(github_user, github_repo, query):
    commits = await query_github_api(github_user, github_repo, query)

    valid_commits = (
        commit for commit in commits if await is_valid(github_user, github_repo, commit)
    )

    return await valid_commits.__anext__()


async def generate(hub, **pkginfo):
    github_user = "mhulden"
    github_repo = "foma"

    target_commit = await get_latest_commit(github_user, github_repo, "commits?path=foma/CHANGELOG&sha=master")
    commit_hash = target_commit["sha"]

    version = await hub.pkgtools.fetch.get_page(
       f"https://raw.githubusercontent.com/{github_user}/{github_repo}/{commit_hash}/foma/CHANGELOG",
       is_json=False,
       refresh_interval=timedelta(days=15),
    )

    # Remove all text after the ) character a.k.a. when the CHANGELOG file is like this
    # 0.10.0 (20210601)
    # ...
    # We remove everything else to get our version
    # Next, replace the " (" string with "_p" to make the version into a regular patch format
    # Finally, if the string contains the word "alpha" we just remove it
    version = version[:version.find(")")].replace(" (", "_p").replace("alpha", "")
    date = version[version.find("_p") + 2:]

    # This commit doesn't have a CMakeLists.txt file so switch to the latest if on it
    if date == "20210601":
        target_commit = await get_latest_commit(github_user, github_repo, "commits?sha=master")
        commit_date = datetime.strptime(
            target_commit["commit"]["committer"]["date"], "%Y-%m-%dT%H:%M:%SZ"
        ).strftime("%Y%m%d")
        commit_hash = target_commit["sha"]
        version = f"0.10.0_p{commit_date}"

    url = f"https://github.com/{github_user}/{github_repo}/archive/{commit_hash}.tar.gz"
    final_name = f"{pkginfo['name']}-{version}.tar.gz"

    ebuild = hub.pkgtools.ebuild.BreezyBuild(
        **pkginfo,
        github_user=github_user,
        github_repo=github_repo,
        version=version,
        artifacts=[hub.pkgtools.ebuild.Artifact(url=url, final_name=final_name)],
    )
    ebuild.push()


