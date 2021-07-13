#!/bin/bash

# Author: @devsecfranklin

IMAGE_DIR="/book/docs/images"
OUTFILE="/book/docs/_source/pictures.rst"

# Check if we are in Docker container
if [ ! -f /.dockerenv ]; then
  echo "Run in the Docker container!"
  exit 1
fi
# Remove stale out file
if [ -f "${OUTFILE}" ]; then
  rm ${OUTFILE}
fi
# source the global functions
echo ".. include:: global.rst" > ${IMAGE_DIR}/header.rst
# add the title to this section
echo "===============" >> ${IMAGE_DIR}/header.rst
echo "Picture Credits" >> ${IMAGE_DIR}/header.rst
echo "===============" >> ${IMAGE_DIR}/header.rst
echo " " >> ${IMAGE_DIR}/header.rst
cat ${IMAGE_DIR}/*.html > ${IMAGE_DIR}/pics.html
pandoc -t rst -o ${IMAGE_DIR}/pics.rst ${IMAGE_DIR}/pics.html
rm ${IMAGE_DIR}/pics.html
cat ${IMAGE_DIR}/header.rst ${IMAGE_DIR}/pics.rst > ${OUTFILE}
rm ${IMAGE_DIR}/*.rst
