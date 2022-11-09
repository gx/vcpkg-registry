set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO sjemens/qsqlcipher-qt5
    REF ee339131c09bad506d24c6753ee1a3e633172899
    SHA512 d6e0fdf5f0fc4b692544ec9055f282cefd9982f2a9cebf39d859dde07a3b417fa95d7c9fb5109d4a56f678217da3d6c9825b0e44291775d1c80065993dc43686
    HEAD_REF 5.15
    PATCHES use-system-sqlcipher.patch
)

set(OPTIONS "CONFIG+=system-sqlcipher")
vcpkg_configure_qmake(SOURCE_PATH ${SOURCE_PATH} OPTIONS ${OPTIONS})
vcpkg_install_qmake()
vcpkg_copy_pdbs()

file(INSTALL ${SOURCE_PATH}/LICENSE
    DESTINATION ${CURRENT_PACKAGES_DIR}/share/qt5-qsqlcipher
    RENAME copyright)
file(MAKE_DIRECTORY ${CURRENT_PACKAGES_DIR}/plugins/sqldrivers ${CURRENT_PACKAGES_DIR}/debug/plugins/sqldrivers)
file(RENAME ${CURRENT_PACKAGES_DIR}/bin/qsqlcipher.dll ${CURRENT_PACKAGES_DIR}/plugins/sqldrivers/qsqlcipher.dll)
file(RENAME ${CURRENT_PACKAGES_DIR}/debug/bin/qsqlcipherd.dll ${CURRENT_PACKAGES_DIR}/debug/plugins/sqldrivers/qsqlcipherd.dll)
file(RENAME ${CURRENT_PACKAGES_DIR}/debug/bin/qsqlcipherd.pdb ${CURRENT_PACKAGES_DIR}/debug/plugins/sqldrivers/qsqlcipherd.pdb)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/bin ${CURRENT_PACKAGES_DIR}/lib ${CURRENT_PACKAGES_DIR}/debug/bin ${CURRENT_PACKAGES_DIR}/debug/lib)
