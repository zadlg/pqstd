list(APPEND VARIANT 2 3 5)

function(get_dilithium_mode var n)
  if(${n} EQUAL 2)
    set(${var}
        "DILITHIUM_MODE=2"
        PARENT_SCOPE)
  elseif(${n} EQUAL 3)
    set(${var}
        "DILITHIUM_MODE=3"
        PARENT_SCOPE)
  elseif(${n} EQUAL 5)
    set(${var}
        "DILITHIUM_MODE=5"
        PARENT_SCOPE)
  else()
    message(FATAL_ERROR "unkown mode for dilithium: ${n}")
  endif()
endfunction()

function(create_target_name var dilithiumVariant name dMode)
  set(${var}
      "dilithium-${dilithiumVariant}-${name}-${dMode}"
      PARENT_SCOPE)
endfunction()

function(add_dilithium_object name srcs headers)
  file(RELATIVE_PATH base "${CMAKE_SOURCE_DIR}" "${CMAKE_CURRENT_SOURCE_DIR}")
  get_filename_component(dilithiumVariant "${CMAKE_CURRENT_SOURCE_DIR}" NAME)
  set(sourceFiles "")
  set(headerFiles "")
  srcs(sourceFiles ${srcs})
  if("${headers}")
    srcs(headerFiles ${headers} "params.h;config.h")
  endif()
  foreach(dMode ${VARIANT})
    get_dilithium_mode(defineDM "${dMode}")
    create_target_name(targetName "${dilithiumVariant}" "${name}" "${dMode}")
    add_library("${targetName}" OBJECT "${sourceFiles}" "${headerFiles}")
    set_target_properties("${targetName}" PROPERTIES POSITION_INDEPENDENT_CODE
                                                     ON)
    target_include_directories("${targetName}"
                               PRIVATE "${PQSTD_SOURCE_DIR}/${base}")
    target_compile_definitions("${targetName}" PRIVATE "${defineDM}")
  endforeach()
endfunction()

function(add_dilithium_object_with_features name srcs headers features)
  add_dilithium_object("${name}" "${srcs}" "${headers}")
  get_filename_component(dilithiumVariant "${CMAKE_CURRENT_SOURCE_DIR}" NAME)
  foreach(dMode ${VARIANT})
    create_target_name(targetName "${dilithiumVariant}" "${name}" "${dMode}")
    foreach(feature ${features})
      target_compile_options("${targetName}" PRIVATE "-m${feature}")
    endforeach()
  endforeach()
endfunction()

function(add_dilithium_library name)
  get_filename_component(dilithiumVariant "${CMAKE_CURRENT_SOURCE_DIR}" NAME)
  foreach(dMode ${VARIANT})
    set(objs "")
    foreach(o ${ARGN})
      create_target_name(targetName "${dilithiumVariant}" "${o}" "${dMode}")
      list(APPEND objs "${targetName}")
    endforeach()
    add_library("${name}-${dMode}")
    target_link_libraries("${name}-${dMode}" ${objs})
  endforeach()
endfunction()

add_subdirectory("ref")

if(PQSTD_AVX2_SUPPORTED)
  add_subdirectory("avx2")
endif()
