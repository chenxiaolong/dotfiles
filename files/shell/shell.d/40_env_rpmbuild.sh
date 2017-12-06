if is_distro Fedora; then

rpmb_here() {
    rpmbuild \
        --define "_builddir     $(pwd)/rpmbuild/BUILD"     \
        --define "_buildrootdir $(pwd)/rpmbuild/BUILDROOT" \
        --define "_rpmdir       $(pwd)/rpmbuild/RPMS"      \
        --define "_sourcedir    $(pwd)/rpmbuild/SOURCES"   \
        --define "_specdir      $(pwd)/rpmbuild/SPECS"     \
        --define "_srcrpmdir    $(pwd)/rpmbuild/SRPMS"     \
        "${@}"
    return ${?}
}

rpmb_cwd() {
    rpmbuild \
        --define "_builddir     $(pwd)/BUILD"     \
        --define "_buildrootdir $(pwd)/BUILDROOT" \
        --define "_rpmdir       $(pwd)"           \
        --define "_sourcedir    $(pwd)"           \
        --define "_specdir      $(pwd)"           \
        --define "_srcrpmdir    $(pwd)"           \
        "${@}"
  return ${?}
}

fi
