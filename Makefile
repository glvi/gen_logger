PROJECT = gen_logger
PROJECT_DESCRIPTION = Erlang gen_logger behaviour
PROJECT_VERSION = 1.2.1

NO_AUTOPATCH = lager

DEPS = lager
dep_lager = git https://github.com/basho/lager.git

COMPILE_FIRST = gen_logger

BUILD_DEPS = hexer_mk
dep_hexer_mk = git https://github.com/inaka/hexer.mk.git 1.1.0
DEP_PLUGINS = hexer_mk

ERLC_OPTS += +warnings_as_errors +warn_export_all +warn_unused_import
ERLC_OPTS += +'{parse_transform, lager_transform}'

#COVER = true

include erlang.mk

app:: rebar.config

