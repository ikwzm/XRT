# Custom variables imported by this CMake stub which should be defined by parent CMake:
# XRT_DKMS_DRIVER_SRC_BASE_DIR
# XRT_VERSION_STRING
# LINUX_KERNEL_VERSION

set (XRT_DKMS_INSTALL_DIR "/usr/src/xrt-${XRT_VERSION_STRING}")
set (XRT_DKMS_INSTALL_DRIVER_DIR "${XRT_DKMS_INSTALL_DIR}/driver")

message("-- XRT DRIVER SRC BASE DIR ${XRT_DKMS_DRIVER_SRC_BASE_DIR}")

SET (DKMS_FILE_NAME "dkms.conf")
SET (DKMS_POSTINST "postinst")
SET (DKMS_PRERM "prerm")

configure_file (
  "${CMAKE_SOURCE_DIR}/CMake/config/dkms-zocl/${DKMS_FILE_NAME}.in"
  ${DKMS_FILE_NAME}
  @ONLY
  )

configure_file (
  "${CMAKE_SOURCE_DIR}/CMake/config/edge/${DKMS_POSTINST}.in"
  ${DKMS_POSTINST}
  @ONLY
  )

configure_file (
  "${CMAKE_SOURCE_DIR}/CMake/config/edge/${DKMS_PRERM}.in"
  ${DKMS_PRERM}
  @ONLY
  )

SET (XRT_DKMS_DRIVER_SRC_DIR     ${XRT_DKMS_DRIVER_SRC_BASE_DIR} )
SET (XRT_DKMS_DRIVER_INCLUDE_DIR ${XRT_DKMS_DRIVER_SRC_BASE_DIR} )
SET (XRT_DKMS_CORE_DIR           ${XRT_DKMS_DRIVER_SRC_BASE_DIR})
SET (XRT_DKMS_CORE_COMMON_DRV    ${XRT_DKMS_CORE_DIR}/common/drv)

SET (XRT_DKMS_DRIVER_SRCS
  edge/drm/zocl/LICENSE
  edge/drm/zocl/Makefile
  edge/drm/zocl/10-zocl.rules
  edge/drm/zocl/sched_exec.c
  edge/drm/zocl/sched_exec.h
  edge/drm/zocl/zocl_bo.c
  edge/drm/zocl/zocl_bo.h
  edge/drm/zocl/zocl_cu.c
  edge/drm/zocl/zocl_cu.h
  edge/drm/zocl/zocl_dma.c
  edge/drm/zocl/zocl_dma.h
  edge/drm/zocl/zocl_drv.c
  edge/drm/zocl/zocl_drv.h
  edge/drm/zocl/zocl_ert.c
  edge/drm/zocl/zocl_ert.h
  edge/drm/zocl/zocl_generic_cu.c
  edge/drm/zocl/zocl_generic_cu.h
  edge/drm/zocl/zocl_ioctl.c
  edge/drm/zocl/zocl_ioctl.h
  edge/drm/zocl/zocl_mailbox.c
  edge/drm/zocl/zocl_mailbox.h
  edge/drm/zocl/zocl_ospi_versal.c
  edge/drm/zocl/zocl_ospi_versal.h
  edge/drm/zocl/zocl_ov_sysfs.c
  edge/drm/zocl/zocl_sk.c
  edge/drm/zocl/zocl_sk.h
  edge/drm/zocl/zocl_sysfs.c
  edge/drm/zocl/zocl_util.h
  edge/drm/zocl/zocl_xclbin.c
  edge/drm/zocl/zocl_xclbin.h
  )

# includes relative to core/edge/
SET (XRT_DKMS_DRIVER_INCLUDES
  edge/include/sk_types.h
  edge/include/xclhal2_mpsoc.h
  edge/include/zynq_ioctl.h
  edge/include/zynq_perfmon_params.h
  )

# includes relative to core
SET (XRT_DKMS_CORE_INCLUDES
  include/ert.h
  include/stream.h
  include/types.h
  include/xbar_sys_parameters.h
  include/xcl_api_macros.h
  include/xcl_app_debug.h
  include/xcl_axi_checker_codes.h
  include/xclbin.h
  include/xclerr.h
  include/xclfeatures.h
  include/xclhal2.h
  include/xclhal2_mem.h
  include/xcl_macros.h
  include/xclperf.h
  include/xcl_perfmon_parameters.h
  include/xrt.h
  include/xrt_mem.h
  include/xstream.h
  )

SET (XRT_DKMS_COMMON_XRT_DRV
  common/drv/xrt_drv.h
  )

SET (XRT_DKMS_ABS_SRCS)

foreach (DKMS_FILE ${XRT_DKMS_DRIVER_SRCS})
  get_filename_component(DKMS_DIR ${DKMS_FILE} DIRECTORY)
  install (FILES ${XRT_DKMS_DRIVER_SRC_DIR}/${DKMS_FILE} DESTINATION ${XRT_DKMS_INSTALL_DRIVER_DIR}/${DKMS_DIR})
endforeach()
  
foreach (DKMS_FILE ${XRT_DKMS_DRIVER_INCLUDES})
  get_filename_component(DKMS_DIR ${DKMS_FILE} DIRECTORY)
  install (FILES ${XRT_DKMS_DRIVER_INCLUDE_DIR}/${DKMS_FILE} DESTINATION ${XRT_DKMS_INSTALL_DRIVER_DIR}/${DKMS_DIR})
endforeach()
  
foreach (DKMS_FILE ${XRT_DKMS_CORE_INCLUDES})
  get_filename_component(DKMS_DIR ${DKMS_FILE} DIRECTORY)
  install (FILES ${XRT_DKMS_CORE_DIR}/${DKMS_FILE} DESTINATION ${XRT_DKMS_INSTALL_DRIVER_DIR}/${DKMS_DIR})
endforeach()

foreach (DKMS_FILE ${XRT_DKMS_COMMON_XRT_DRV})
  get_filename_component(DKMS_DIR ${DKMS_FILE} DIRECTORY)
  install (FILES ${XRT_DKMS_CORE_DIR}/${DKMS_FILE} DESTINATION ${XRT_DKMS_INSTALL_DRIVER_DIR}/include/)
endforeach()

install (FILES ${CMAKE_CURRENT_BINARY_DIR}/${DKMS_FILE_NAME} DESTINATION ${XRT_DKMS_INSTALL_DIR})

