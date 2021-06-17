FROM geoschem/buildmatrix:netcdf-ubuntu

# Make a directory to install GEOS-Chem to
RUN mkdir /opt/geos-chem && mkdir /opt/geos-chem/bin

# Copy the GEOS-Chem repository (".") to /gc-src
# This means this docker build command's context must be 
# GEOS-Chem's root source code directory
COPY . /gc-src
RUN cd /gc-src \
&&  mkdir build

RUN echo ". /opt/spack/share/spack/setup-env.sh" >> /init.rc \
&&  echo "export CC=gcc" >> /init.rc \
&&  echo "export CXX=g++" >> /init.rc \
&&  echo "export FC=gfortran" >> /init.rc \
&&  echo "spack load cmake" >> /init.rc \
&&  echo "spack load netcdf-c" >> /init.rc \
&&  echo "spack load netcdf-fortran" >> /init.rc \
&&  echo 'export PATH=$PATH:/opt/geos-chem/bin' >> /init.rc

# Make bash the default shell
SHELL ["/bin/bash", "-c"]

# Build fullchem and copy the executable to /opt/geos-chem/bin
RUN source /init.rc \
&&  cd /gc-src/build \
&&  cmake -DRUNDIR=IGNORE -DRUNDIR_SIM=fullchem -DCMAKE_COLOR_MAKEFILE=FALSE .. \
&&  make -j install \
&&  cp gcclassic /opt/geos-chem/bin/ \
&& rm -rf /gc-src/build/*

# Create fake createRunDir.sh that calls the actual one
RUN echo "#!/usr/bin/env bash" > /opt/geos-chem/bin/createRunDir.sh \
&&  echo "cd /gc-src/run" >> /opt/geos-chem/bin/createRunDir.sh \
&&  echo "bash createRunDir.sh" >> /opt/geos-chem/bin/createRunDir.sh \
&&  chmod +x /opt/geos-chem/bin/createRunDir.sh

RUN echo "#!/usr/bin/env bash" > /usr/bin/start-container.sh \
&&  echo ". /init.rc" >> /usr/bin/start-container.sh \
&&  echo 'if [ $# -gt 0 ]; then exec "$@"; else /bin/bash ; fi' >> /usr/bin/start-container.sh \
&&  chmod +x /usr/bin/start-container.sh
ENTRYPOINT ["start-container.sh"]
