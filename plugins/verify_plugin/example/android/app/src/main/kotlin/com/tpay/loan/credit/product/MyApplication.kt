package com.tpay.loan.credit.product

import android.app.Application
import com.liveness.dflivenesslibrary.DFProductResult
import com.liveness.dflivenesslibrary.DFTransferResultInterface

class MyApplication :Application() , DFTransferResultInterface {
    private var mResult: DFProductResult? = null
    override fun setResult(p0: DFProductResult?) {
        mResult = p0
    }

    override fun getResult(): DFProductResult? {
        return  mResult
    }
}