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

SET (XRT_DKMS_DRIVER_SRC_DIR     ${XRT_DKMS_DRIVER_SRC_BASE_DIR}/edge/ )
SET (XRT_DKMS_DRIVER_INCLUDE_DIR ${XRT_DKMS_DRIVER_SRC_BASE_DIR}/edge/ )
SET (XRT_DKMS_CORE_DIR ${XRT_DKMS_DRIVER_SRC_BASE_DIR})
SET (XRT_DKMS_CORE_COMMON_DRV ${XRT_DKMS_CORE_DIR}/common/drv)

SET (XRT_DKMS_DRIVER_SRCS
  drm/zocl/LICENSE
  drm/zocl/Makefile
  drm/zocl/sched_exec.c
  drm/zocl/sched_exec.h
  drm/zocl/zocl_bo.c
  drm/zocl/zocl_bo.h
  drm/zocl/zocl_cu.c
  drm/zocl/zocl_cu.h
  drm/zocl/zocl_dma.c
  drm/zocl/zocl_dma.h
  drm/zocl/zocl_drv.c
  drm/zocl/zocl_drv.h
  drm/zocl/zocl_ert.c
  drm/zocl/zocl_ert.h
  drm/zocl/zocl_generic_cu.c
  drm/zocl/zocl_generic_cu.h
  drm/zocl/zocl_ioctl.c
  drm/zocl/zocl_ioctl.h
  drm/zocl/zocl_mailbox.c
  drm/zocl/zocl_mailbox.h
  drm/zocl/zocl_ospi_versal.c
  drm/zocl/zocl_ospi_versal.h
  drm/zocl/zocl_ov_sysfs.c
  drm/zocl/zocl_sk.c
  drm/zocl/zocl_sk.h
  drm/zocl/zocl_sysfs.c
  drm/zocl/zocl_util.h
  drm/zocl/zocl_xclbin.c
  drm/zocl/zocl_xclbin.h
  )

# includes relative to core/edge/
SET (XRT_DKMS_DRIVER_INCLUDES
  include/sk_types.h
  include/xclhal2_mpsoc.h
  include/zynq_ioctl.h
  include/zynq_perfmon_params.h
  )

# includes relative to core
SET (XRT_DKMS_CORE_INCLUDES
  include/ert.h
  include/xclfeatures.h
  include/xclbin.h
  include/xclerr.h
  include/xrt_mem.h
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

