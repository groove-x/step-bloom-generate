#!/bin/bash

set -e

apt --yes install devscripts fakeroot python-bloom

NOW=`date -u +'%Y%m%dT%H%M%SZ'`
bloom-generate rosdebian \
               --os-name ${WERCKER_BLOOM_GENERATE_OS_NAME} \
               --os-version ${WERCKER_BLOOM_GENERATE_OS_VERSION} \
               --ros-distro ${WERCKER_BLOOM_GENERATE_ROS_DISTRO}
sed -i -e "1 s/-\w*)/-${NOW})/" debian/changelog
fakeroot debian/rules clean
fakeroot debian/rules binary
