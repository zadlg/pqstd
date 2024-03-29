list(APPEND VARIANT 512 768 1024)

function(get_kyber_k var n)
  if(${n} EQUAL 512)
    set(${var}
        "KYBER_K=2"
        PARENT_SCOPE)
  elseif(${n} EQUAL 768)
    set(${var}
        "KYBER_K=3"
        PARENT_SCOPE)
  elseif(${n} EQUAL 1024)
    set(${var}
        "KYBER_K=4"
        PARENT_SCOPE)
  else()
    message(FATAL_ERROR "unkown secBits for Kyber: ${n}")
  endif()
endfunction()

function(create_target_name var kyberVariant name sBits)
  set(${var}
      "kyber-${kyberVariant}-${name}-${sBits}"
      PARENT_SCOPE)
endfunction()

function(add_kyber_object name srcs headers)
  file(RELATIVE_PATH base "${CMAKE_SOURCE_DIR}" "${CMAKE_CURRENT_SOURCE_DIR}")
  get_filename_component(kyberVariant "${CMAKE_CURRENT_SOURCE_DIR}" NAME)
  set(sourceFiles "")
  set(headerFiles "")
  srcs(sourceFiles ${srcs})
  if("${headers}")
    srcs(headerFiles ${headers} "params.h")
  endif()
  foreach(sBits ${VARIANT})
    get_kyber_k(kyberK "${sBits}")
    create_target_name(targetName "${kyberVariant}" "${name}" "${sBits}")
    add_library("${targetName}" OBJECT "${sourceFiles}" "${headerFiles}")
    set_target_properties("${targetName}" PROPERTIES POSITION_INDEPENDENT_CODE
                                                     ON)
    target_include_directories("${targetName}"
                               PRIVATE "${PQSTD_SOURCE_DIR}/${base}")
    target_compile_definitions("${targetName}" PRIVATE "${kyberK}")
  endforeach()
endfunction()

function(add_kyber_object_with_features name srcs headers features)
  add_kyber_object("${name}" "${srcs}" "${headers}")
  get_filename_component(kyberVariant "${CMAKE_CURRENT_SOURCE_DIR}" NAME)
  foreach(sBits ${VARIANT})
    get_kyber_k(kyberK "${sBits}")
    create_target_name(targetName "${kyberVariant}" "${name}" "${sBits}")
    foreach(feature ${features})
      target_compile_options("${targetName}" PRIVATE "-m${feature}")
    endforeach()
  endforeach()
endfunction()

function(add_kyber_library name)
  get_filename_component(kyberVariant "${CMAKE_CURRENT_SOURCE_DIR}" NAME)
  foreach(sBits ${VARIANT})
    set(objs "")
    foreach(o ${ARGN})
      create_target_name(targetName "${kyberVariant}" "${o}" "${sBits}")
      list(APPEND objs "${targetName}")
    endforeach()
    add_library("${name}-${sBits}")
    target_link_libraries("${name}-${sBits}" ${objs})
  endforeach()
endfunction()

add_subdirectory("ref")
add_subdirectory("avx2")
