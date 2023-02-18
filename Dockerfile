FROM cross-pi AS builder

COPY ./src /code/src
COPY ./include /code/include
COPY ./CMakeLists.txt /code/

ENV BIN_DIR /tmp/bin
ENV BUILD_DIR /code/build

RUN mkdir -p $BIN_DIR && \
  mkdir -p $BUILD_DIR && \
  cd $BUILD_DIR && \
  cmake -DCMAKE_TOOLCHAIN_FILE=$CROSS_TOOLCHAIN \
    -DCMAKE_INSTALL_PREFIX=$CROSS_INSTALL_PREFIX \
    ..  && \
  cmake --build . && \
  cp ./MySaw.so $BIN_DIR/

FROM scratch
COPY --from=builder /tmp/bin /
