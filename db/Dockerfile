FROM mysql:8

ENV FILE_0 ibooking.sql
ENV AUTO_RUN_DIR /docker-entrypoint-initdb.d
ENV INSTALL_DATA_SHELL setup.sh
ENV WORK_PATH /usr/local/work

RUN mkdir -p $WORK_PATH
COPY ./ibooking.sql $WORK_PATH/
COPY ./$INSTALL_DATA_SHELL $AUTO_RUN_DIR/

EXPOSE 3306
