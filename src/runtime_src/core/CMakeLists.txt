include_directories(
  ${CMAKE_CURRENT_SOURCE_DIR}
  )

add_subdirectory(include)
add_subdirectory(common)
 if (${XRT_EDGE_BUILD} STREQUAL "yes")
   add_subdirectory(edge)
 else()
   add_subdirectory(pcie)
   add_subdirectory(tools)
 endif()
