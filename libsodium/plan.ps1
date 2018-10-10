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

function Invoke-Build {
    cd "$pkg_name-$pkg_version"
    cd builds/msvc
    msbuild.exe /m /p:Configuration=StaticRelease /p:Platform=x64 vs2015\libsodium.sln
}

function Invoke-Install {
    Copy-Item "$HAB_CACHE_SRC_PATH\$pkg_name-$pkg_version\$pkg_name-$pkg_version\bin\x64\Release\v140\static\*" "$pkg_prefix\lib\" -Force
}
