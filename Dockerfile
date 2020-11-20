# build stage
FROM python:3-slim AS build-env
LABEL maintainer="sakurai.youhei@gmail.com"
ADD . /src
WORKDIR /src
RUN python3 setup.py clean bdist_wheel

# container stage
FROM python:3-slim
COPY --from=build-env /src/dist /tmp/dist
RUN pip3 install /tmp/dist/*.whl && \
    pip3 cache purge && \
    rm -rf /tmp/dist/
ENTRYPOINT ["/usr/local/bin/shukujitsu"]