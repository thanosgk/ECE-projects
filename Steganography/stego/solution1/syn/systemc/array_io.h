// ==============================================================
// RTL generated by Vivado(TM) HLS - High-Level Synthesis from C, C++ and SystemC
// Version: 2014.4
// Copyright (C) 2014 Xilinx Inc. All rights reserved.
// 
// ===========================================================

#ifndef _array_io_HH_
#define _array_io_HH_

#include "systemc.h"
#include "AESL_pkg.h"


namespace ap_rtl {

struct array_io : public sc_module {
    // Port declarations 16
    sc_in_clk ap_clk;
    sc_in< sc_logic > ap_rst;
    sc_in< sc_logic > ap_start;
    sc_out< sc_logic > ap_done;
    sc_out< sc_logic > ap_idle;
    sc_out< sc_logic > ap_ready;
    sc_out< sc_lv<20> > d_o_address0;
    sc_out< sc_logic > d_o_ce0;
    sc_out< sc_logic > d_o_we0;
    sc_out< sc_lv<16> > d_o_d0;
    sc_out< sc_lv<20> > d_i_address0;
    sc_out< sc_logic > d_i_ce0;
    sc_in< sc_lv<16> > d_i_q0;
    sc_out< sc_lv<5> > m_i_address0;
    sc_out< sc_logic > m_i_ce0;
    sc_in< sc_lv<16> > m_i_q0;


    // Module declarations
    array_io(sc_module_name name);
    SC_HAS_PROCESS(array_io);

    ~array_io();

    sc_trace_file* mVcdFile;

    ofstream mHdltvinHandle;
    ofstream mHdltvoutHandle;
    sc_signal< sc_lv<6> > ap_CS_fsm;
    sc_signal< sc_logic > ap_sig_cseq_ST_st1_fsm_0;
    sc_signal< bool > ap_sig_bdd_22;
    sc_signal< sc_lv<20> > i_2_fu_214_p2;
    sc_signal< sc_lv<20> > i_2_reg_334;
    sc_signal< sc_logic > ap_sig_cseq_ST_st2_fsm_1;
    sc_signal< bool > ap_sig_bdd_55;
    sc_signal< sc_lv<64> > tmp_fu_220_p1;
    sc_signal< sc_lv<64> > tmp_reg_339;
    sc_signal< sc_lv<1> > exitcond2_fu_208_p2;
    sc_signal< sc_lv<5> > i_3_fu_231_p2;
    sc_signal< sc_lv<5> > i_3_reg_352;
    sc_signal< sc_logic > ap_sig_cseq_ST_st4_fsm_3;
    sc_signal< bool > ap_sig_bdd_72;
    sc_signal< sc_lv<9> > k_2_fu_237_p2;
    sc_signal< sc_lv<9> > k_2_reg_357;
    sc_signal< sc_lv<1> > exitcond1_fu_225_p2;
    sc_signal< sc_lv<5> > m_i_addr_reg_362;
    sc_signal< sc_lv<64> > tmp_5_fu_254_p1;
    sc_signal< sc_lv<64> > tmp_5_reg_370;
    sc_signal< sc_logic > ap_sig_cseq_ST_st5_fsm_4;
    sc_signal< bool > ap_sig_bdd_88;
    sc_signal< sc_lv<1> > exitcond_fu_248_p2;
    sc_signal< sc_lv<9> > tmp_1_fu_319_p2;
    sc_signal< sc_logic > ap_sig_cseq_ST_st6_fsm_5;
    sc_signal< bool > ap_sig_bdd_102;
    sc_signal< sc_lv<4> > j_1_fu_325_p2;
    sc_signal< sc_lv<20> > i_reg_150;
    sc_signal< sc_logic > ap_sig_cseq_ST_st3_fsm_2;
    sc_signal< bool > ap_sig_bdd_117;
    sc_signal< sc_lv<5> > i_1_reg_161;
    sc_signal< sc_lv<9> > k_reg_172;
    sc_signal< sc_lv<4> > j_reg_184;
    sc_signal< sc_lv<9> > k_1_reg_196;
    sc_signal< sc_lv<64> > tmp_3_fu_243_p1;
    sc_signal< sc_lv<1> > tmp_tmp_fu_287_p2;
    sc_signal< sc_lv<20> > d_o_addr_3_gep_fu_134_p3;
    sc_signal< sc_lv<1> > image_lsb_fu_259_p1;
    sc_signal< sc_lv<20> > d_o_addr_4_gep_fu_142_p3;
    sc_signal< sc_lv<16> > tmp_2_fu_293_p2;
    sc_signal< sc_lv<16> > tmp_4_fu_310_p3;
    sc_signal< sc_lv<3> > tmp_10_fu_263_p1;
    sc_signal< sc_lv<3> > tmp_8_fu_267_p2;
    sc_signal< sc_lv<16> > tmp_8_cast_fu_273_p1;
    sc_signal< sc_lv<16> > tmp_9_fu_277_p2;
    sc_signal< sc_lv<1> > message_bit_fu_283_p1;
    sc_signal< sc_lv<15> > tmp_6_fu_300_p4;
    sc_signal< sc_lv<6> > ap_NS_fsm;
    static const sc_logic ap_const_logic_1;
    static const sc_logic ap_const_logic_0;
    static const sc_lv<6> ap_ST_st1_fsm_0;
    static const sc_lv<6> ap_ST_st2_fsm_1;
    static const sc_lv<6> ap_ST_st3_fsm_2;
    static const sc_lv<6> ap_ST_st4_fsm_3;
    static const sc_lv<6> ap_ST_st5_fsm_4;
    static const sc_lv<6> ap_ST_st6_fsm_5;
    static const sc_lv<32> ap_const_lv32_0;
    static const sc_lv<1> ap_const_lv1_1;
    static const sc_lv<32> ap_const_lv32_1;
    static const sc_lv<1> ap_const_lv1_0;
    static const sc_lv<32> ap_const_lv32_3;
    static const sc_lv<32> ap_const_lv32_4;
    static const sc_lv<32> ap_const_lv32_5;
    static const sc_lv<20> ap_const_lv20_0;
    static const sc_lv<32> ap_const_lv32_2;
    static const sc_lv<5> ap_const_lv5_0;
    static const sc_lv<9> ap_const_lv9_96;
    static const sc_lv<4> ap_const_lv4_1;
    static const sc_lv<64> ap_const_lv64_95;
    static const sc_lv<16> ap_const_lv16_1B;
    static const sc_lv<20> ap_const_lv20_BEC58;
    static const sc_lv<20> ap_const_lv20_1;
    static const sc_lv<5> ap_const_lv5_1B;
    static const sc_lv<5> ap_const_lv5_1;
    static const sc_lv<9> ap_const_lv9_8;
    static const sc_lv<4> ap_const_lv4_9;
    static const sc_lv<3> ap_const_lv3_0;
    static const sc_lv<16> ap_const_lv16_1;
    static const sc_lv<32> ap_const_lv32_F;
    static const sc_lv<9> ap_const_lv9_1;
    // Thread declarations
    void thread_ap_clk_no_reset_();
    void thread_ap_done();
    void thread_ap_idle();
    void thread_ap_ready();
    void thread_ap_sig_bdd_102();
    void thread_ap_sig_bdd_117();
    void thread_ap_sig_bdd_22();
    void thread_ap_sig_bdd_55();
    void thread_ap_sig_bdd_72();
    void thread_ap_sig_bdd_88();
    void thread_ap_sig_cseq_ST_st1_fsm_0();
    void thread_ap_sig_cseq_ST_st2_fsm_1();
    void thread_ap_sig_cseq_ST_st3_fsm_2();
    void thread_ap_sig_cseq_ST_st4_fsm_3();
    void thread_ap_sig_cseq_ST_st5_fsm_4();
    void thread_ap_sig_cseq_ST_st6_fsm_5();
    void thread_d_i_address0();
    void thread_d_i_ce0();
    void thread_d_o_addr_3_gep_fu_134_p3();
    void thread_d_o_addr_4_gep_fu_142_p3();
    void thread_d_o_address0();
    void thread_d_o_ce0();
    void thread_d_o_d0();
    void thread_d_o_we0();
    void thread_exitcond1_fu_225_p2();
    void thread_exitcond2_fu_208_p2();
    void thread_exitcond_fu_248_p2();
    void thread_i_2_fu_214_p2();
    void thread_i_3_fu_231_p2();
    void thread_image_lsb_fu_259_p1();
    void thread_j_1_fu_325_p2();
    void thread_k_2_fu_237_p2();
    void thread_m_i_address0();
    void thread_m_i_ce0();
    void thread_message_bit_fu_283_p1();
    void thread_tmp_10_fu_263_p1();
    void thread_tmp_1_fu_319_p2();
    void thread_tmp_2_fu_293_p2();
    void thread_tmp_3_fu_243_p1();
    void thread_tmp_4_fu_310_p3();
    void thread_tmp_5_fu_254_p1();
    void thread_tmp_6_fu_300_p4();
    void thread_tmp_8_cast_fu_273_p1();
    void thread_tmp_8_fu_267_p2();
    void thread_tmp_9_fu_277_p2();
    void thread_tmp_fu_220_p1();
    void thread_tmp_tmp_fu_287_p2();
    void thread_ap_NS_fsm();
    void thread_hdltv_gen();
};

}

using namespace ap_rtl;

#endif
