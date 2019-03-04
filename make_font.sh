#!/bin/sh

SRC_FONTBASE=$1
CMAP=$2

TTXVER=`ttx --version`
TOOLVER="ttx ${TTXVER}"

cd build/${SRC_FONTBASE}

BASEDIR=../..
BINDIR=${BASEDIR}/bin
TTXDIR=${BASEDIR}/ttx
DOWNLOADDIR=${BASEDIR}/download

echo making conversion table...
${BINDIR}/make_conv_table \
    ${TTXDIR}/${SRC_FONTBASE}._c_m_a_p.ttx ${DOWNLOADDIR}/${CMAP} \
    > table.tbl 2> table.log

echo making glyphorder...
${BINDIR}/make_glyphorder \
    table.tbl \
    > glyphorder.ttx 2> glyphorder.log

echo converting name table...
${BINDIR}/conv_name \
    ${SRC_FONTBASE} "${TOOLVER}" ${TTXDIR}/${SRC_FONTBASE}._n_a_m_e.ttx \
    2> name.log | sed -f ${BASEDIR}/font_name.sed > name.ttx
echo converting cmap table...
${BINDIR}/conv_cmap \
    table.tbl ${TTXDIR}/${SRC_FONTBASE}._c_m_a_p.ttx \
    > cmap.ttx 2> cmap.log
echo converting CFF table...
${BINDIR}/conv_CFF \
    table.tbl ${TTXDIR}/${SRC_FONTBASE}.C_F_F_.ttx \
    2> CFF.log | sed -f ${BASEDIR}/font_name.sed > CFF.ttx
echo converting VORG table...
${BINDIR}/conv_VORG \
    table.tbl ${TTXDIR}/${SRC_FONTBASE}.V_O_R_G_.ttx \
    > VORG.ttx 2> VORG.log
echo converting hmtx table...
${BINDIR}/conv_mtx \
    table.tbl ${TTXDIR}/${SRC_FONTBASE}._h_m_t_x.ttx \
    > hmtx.ttx 2> hmtx.log
echo converting vmtx table...
${BINDIR}/conv_mtx \
    table.tbl ${TTXDIR}/${SRC_FONTBASE}._v_m_t_x.ttx \
    > vmtx.ttx 2> vmtx.log

echo symbolic linking other tables...
ln -s ${TTXDIR}/${SRC_FONTBASE}._h_e_a_d.ttx
ln -s ${TTXDIR}/${SRC_FONTBASE}._h_h_e_a.ttx
ln -s ${TTXDIR}/${SRC_FONTBASE}._m_a_x_p.ttx
ln -s ${TTXDIR}/${SRC_FONTBASE}.O_S_2f_2.ttx
ln -s ${TTXDIR}/${SRC_FONTBASE}._p_o_s_t.ttx
ln -s ${TTXDIR}/${SRC_FONTBASE}.B_A_S_E_.ttx
ln -s ${TTXDIR}/${SRC_FONTBASE}._v_h_e_a.ttx

echo converting root ttx file...
sed -f ${BASEDIR}/font_tables.sed ${TTXDIR}/${SRC_FONTBASE}.ttx \
    > output.ttx

ttx -b --recalc-timestamp output.ttx
