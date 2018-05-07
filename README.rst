===========================
dev-kit
===========================
1.2-prime branch
---------------------------

Dev-kit contains a variety of development and server-related ebuilds. It is designed to be a part of the Funtoo Linux
kits system.

The ``-prime`` suffix indicates that the eventual goal is for this kit branch to reach production-quality and
enterprise-class stability. Once this is achieved, we will only incorporate bug fixes for specific issues, and security
backports. We will *not* be bumping versions of ebuilds unless absolutely necessary and we have very strong belief that
they will not negatively impact the functionality on anyone's system.

You can track the stability rating of this branch by using the ``ego kit list`` command, which will display the current
stability rating of this kit branch.

--------------
Security Fixes
--------------

- ``dev-db/mariadb`` has been updated to 10.1.32 to address CVE-2018-2562, CVE-2018-2622, CVE-2018-2640, CVE-2018-2665,
  CVE-2018-2668, CVE-2018-2612.

Reporting Bugs
---------------

To report bugs or suggest improvements to dev-kit, please use the Funtoo Linux bug tracker at https://bugs.funtoo.org.
Thank you! :)
