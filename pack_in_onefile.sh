#!/bin/sh
#
# Run for create one-file-scripts
#
# Copyright (C) 2012  Etersoft
# Copyright (C) 2012  Vitaly Lipatov <lav@etersoft.ru>
#
# This file is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301, USA.
#


incorporate_distr_info()
{
cat <<EOF >>$OUTPUT
internal_distr_info()
{
EOF

cat bin/distr_info >>$OUTPUT

cat <<EOF >>$OUTPUT
}
EOF
}

filter_out()
{
	grep -v "^load_helper " | sed -e 's|DISTRVENDOR=$PROGDIR/distr_info|DISTRVENDOR=internal_distr_info|g'
}

incorporate_all()
{
OUTPUT=$PACKCOMMAND-packed.sh
echo -n >$OUTPUT
awk 'BEGIN{desk=0}{if(/^load_helper epm-sh-functions/){desk++};if(desk==0) {print}}' <bin/$PACKCOMMAND | filter_out >>$OUTPUT

for i in bin/epm-sh-functions $(ls -1 bin/$PACKCOMMAND-* | grep -v epm-sh-functions | sort) ; do
	echo
	echo "# File $i:"
	cat $i | grep -v "^#"
done | filter_out >>$OUTPUT

incorporate_distr_info

awk 'BEGIN{desk=0}{if(desk>0) {print} ; if(/^load_helper epm-sh-functions/){desk++}}' <bin/$PACKCOMMAND | filter_out >>$OUTPUT
}

###############
PACKCOMMAND=epm
incorporate_all

###############
PACKCOMMAND=serv
incorporate_all
