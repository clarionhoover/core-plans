$pkg_name="libarchive"
$pkg_origin="core"
$pkg_version="3.3.2"
$pkg_description="Multi-format archive and compression library"
$pkg_upstream_url="https://www.libarchive.org"
$pkg_license=@("BSD")
$pkg_source="http://www.libarchive.org/downloads/${pkg_name}-${pkg_version}.zip"
$pkg_shasum="94e5fe36ea658b2ac91e036b178930735c537f14dcb54434a05530d2a14435ee"
$pkg_deps=@(
    "core/openssl",
    "core/bzip2"
)
$pkg_build_deps=@("core/visual-cpp-build-tools-2015", "core/cmake", "core/zlib")
$pkg_lib_dirs=@("lib")

function Invoke-Build {
    cd "$pkg_name-$pkg_version"

    $bzip_lib = "$(Get-HabPackagePath bzip2)\lib\libbz2.lib"
    $bzip_includedir = "$(Get-HabPackagePath bzip2)\include"
    $zlib_libdir = "$(Get-HabPackagePath zlib)\lib\zlibwapi.lib"
    $zlib_includedir = "$(Get-HabPackagePath zlib)\include"

    cmake -G "Visual Studio 14 2015 Win64" -T "v140" -DCMAKE_SYSTEM_VERSION="8.1" -DCMAKE_INSTALL_PREFIX="${prefix_path}\libarchive" -DBZIP2_LIBRARY_RELEASE="${bzip_lib}" -DBZIP2_INCLUDE_DIR="${bzip_includedir}" -DZLIB_LIBRARY_RELEASE="${zlib_libdir}" -DZLIB_INCLUDE_DIR="${zlib_includedir}"
    msbuild /p:Configuration=Release /p:Platform=x64 "ALL_BUILD.vcxproj"
}

function Invoke-Install {
    Copy-Item "$HAB_CACHE_SRC_PATH\$pkg_name-$pkg_version\$pkg_name-$pkg_version\$pkg_name\Release\*.lib" "$pkg_prefix\lib\" -Force
}
