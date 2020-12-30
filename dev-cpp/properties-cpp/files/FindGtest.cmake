include(FindPackageHandleStandardArgs)

find_path(GTEST_INCLUDE_DIR gtest/gtest.h)
find_path(GMOCK_INCLUDE_DIR gmock/gmock.h)

find_library(GMOCK_LIBRARY libgmock.so)
find_library(GMOCK_MAIN_LIBRARY libgmock_main.so)
find_library(GTEST_LIBRARY libgtest.so)
find_library(GTEST_MAIN_LIBRARY libgtest_main.so)

set(GMOCK_BOTH_LIBRARIES ${GMOCK_LIBRARY} ${GMOCK_MAIN_LIBRARY})
set(GTEST_BOTH_LIBRARIES ${GTEST_LIBRARY} ${GTEST_MAIN_LIBRARY})
set(GTEST_LIBRARIES ${GTEST_BOTH_LIBRARIES} ${GMOCK_BOTH_LIBRARIES})

find_package_handle_standard_args(Gtest  DEFAULT_MSG
                                    GMOCK_INCLUDE_DIR
                                    GTEST_INCLUDE_DIR)
