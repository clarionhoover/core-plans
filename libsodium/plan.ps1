$pkg_name="libsodium"
$pkg_origin="core"
$pkg_version="1.0.13"
$_pkg_version_text=($pkg_version).Replace(".", "_")
$pkg_description="Sodium is a new, easy-to-use software library for encryption, decryption, signatures, password hashing and more. It is a portable, cross-compilable, installable, packageable fork of NaCl, with a compatible API, and an extended API to improve usability even further."
$pkg_upstream_url="https://github.com/jedisct1/libsodium"
$pkg_license=@("ISC")
$pkg_source="https://github.com/jedisct1/libsodium/archive/$pkg_version.zip"
$pkg_shasum="1a9d20aa5f06ad208dee765fd6ce7a2b06eab067ed5ca15f9caaf247f4358e67"
$pkg_build_deps=@("core/visual-cpp-build-tools-2015")
$pkg_lib_dirs=@("lib")
$pkg_include_dirs=@("include")

function Invoke-Build {
    cd "$pkg_name-$pkg_version"
    msbuild.exe /m /p:Configuration=Release /p:Platform=x64 libsodium.sln
}

function Invoke-Install {
    $build_path = "$HAB_CACHE_SRC_PATH\$pkg_name-$pkg_version\$pkg_name-$pkg_version"

    Copy-Item "$build_path\Build\Release\x64\libsodium.*" "$pkg_prefix\lib\" -Force
    Copy-Item "$build_path\src\$pkg_name\include\*.h" "$pkg_prefix\include\" -Force
    mkdir "$pkg_prefix\include\sodium\"
    Copy-Item "$build_path\src\$pkg_name\include\sodium\*.h" "$pkg_prefix\include\sodium\" -Force
}
