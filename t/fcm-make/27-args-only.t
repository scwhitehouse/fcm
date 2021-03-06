#!/bin/bash
#-------------------------------------------------------------------------------
# (C) British Crown Copyright 2006-16 Met Office.
#
# This file is part of FCM, tools for managing and building source code.
#
# FCM is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# FCM is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with FCM. If not, see <http://www.gnu.org/licenses/>.
#-------------------------------------------------------------------------------
# Tests "fcm make", no configuration files, only CLI arguments.
#-------------------------------------------------------------------------------
. $(dirname $0)/test_header
#-------------------------------------------------------------------------------
tests 3
#-------------------------------------------------------------------------------
TEST_KEY="$TEST_KEY_BASE"
mkdir src
cat >src/hello.f90 <<'__FORTRAN__'
program hello
write(*, '(a)') 'Hello World!'
end program hello
__FORTRAN__
run_pass "$TEST_KEY" fcm make \
    'steps=build' "build.source=$PWD/src" 'build.target=hello.exe'
file_test "$TEST_KEY.hello.exe" $PWD/build/bin/hello.exe
$PWD/build/bin/hello.exe >"$TEST_KEY.hello.exe.out"
file_cmp "$TEST_KEY.hello.exe.out" "$TEST_KEY.hello.exe.out" <<'__OUT__'
Hello World!
__OUT__
#-------------------------------------------------------------------------------
exit 0
