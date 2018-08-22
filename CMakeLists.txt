# -*- mode: cmake; coding: utf-8; indent-tabs-mode: nil; -*-
project(gen_logger
  VERSION 1.0.0
  DESCRIPTION "EMQTT logger"
  LANGUAGES NONE)
set(gen_logger_source_dir
  ${CMAKE_CURRENT_SOURCE_DIR}/src)
set(GEN_LOGGER_MODULES
  gen_logger # must go first
  console_logger
  error_logger_logger)
foreach(module IN LISTS GEN_LOGGER_MODULES)
  list(APPEND GEN_LOGGER_SOURCES    ${gen_logger_source_dir}/${module}.erl)
  list(APPEND GEN_LOGGER_OBJECTS    ${CMAKE_CURRENT_BINARY_DIR}/ebin/${module}.beam)
  list(APPEND GEN_LOGGER_MODULES_Q '${module}')
endforeach()
file(RELATIVE_PATH gen_logger_include_dir ${gen_logger_source_dir} ${CMAKE_CURRENT_SOURCE_DIR}/include)
file(RELATIVE_PATH gen_logger_binary_dir  ${gen_logger_source_dir} ${CMAKE_CURRENT_BINARY_DIR}/ebin)
string(REPLACE ";" "," gen_logger_modules "${GEN_LOGGER_MODULES_Q}")
configure_file(Emakefile.in ${gen_logger_source_dir}/Emakefile)
configure_file(${gen_logger_source_dir}/gen_logger.app.src ebin/gen_logger.app)
add_custom_target(EmqttLogger
  BYPRODUCTS ${GEN_LOGGER_OBJECTS}
  DEPENDS    ${GEN_LOGGER_SOURCES}
  COMMAND    ${CMAKE_COMMAND} -E make_directory ${gen_logger_binary_dir}
  COMMAND    ${CMAKE_COMMAND} -E copy_directory ${gen_logger_include_dir} ${CMAKE_CURRENT_BINARY_DIR}
  COMMAND    ${ERLANG_PROGRAM} -pa ${gen_logger_binary_dir} -sasl errlog_type error -make
  WORKING_DIRECTORY ${gen_logger_source_dir}
  VERBATIM
  COMMAND_EXPAND_LISTS)
add_dependencies(EmqttLogger ErlangOTP)
set(URBANATM_GEN_LOGGER_OBJECTS ${GEN_LOGGER_OBJECTS} CACHE INTERNAL "UrbanATM Erlang EMQTT logger objects" FORCE)
add_custom_target(DialyzeEmqttLogger
  COMMAND ${DIALYZER_PROGRAM}
          --fullpath
          --plt ${DIALYZER_PLT}
          -I ${CMAKE_CURRENT_SOURCE_DIR}/include
          -pa ${CMAKE_CURRENT_BINARY_DIR}/ebin
          --src ${gen_logger_source_dir}/gen_logger.erl
  DEPENDS ${DIALYZER_PLT}
  )
add_dependencies(DialyzeEmqttLogger
  DialyzerPlt
  EmqttLogger)
