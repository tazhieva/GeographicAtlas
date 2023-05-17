//
//  Currencies.swift
//  GeographicAtlas
//
//  Created by Акмарал Тажиева on 16.05.2023.
//

import Foundation

// MARK: - Currencies
struct Currencies: Codable {
    let vuv, gbp, ggp, syp: Aed?
    let eur, mwk, khr, usd: Aed?
    let sbd, dop, cad, uyu: Aed?
    let xcd, byn, pkr, sar: Aed?
    let huf, lkr: Aed?
    let bam: BAM?
    let kpw, tzs, gyd, npr: Aed?
    let jod, iqd, sll, shp: Aed?
    let chf, pgk, mop, lak: Aed?
    let bnd, sgd, tjs, irr: Aed?
    let mga, ang, azn, amd: Aed?
    let ugx, inr, xpf, sek: Aed?
    let dzd, nzd, bhd, thb: Aed?
    let hkd, cve, uzs, qar: Aed?
    let ssp, ghs, bzd, twd: Aed?
    let aud, zwl, vnd, kes: Aed?
    let xaf, xof, aoa, tvd: Aed?
    let mur, idr, scr, awg: Aed?
    let ngn, fjd, zmw, bsd: Aed?
    let kmf, aed, pyg, czk: Aed?
    let mxn, mdl, bob, cny: Aed?
    let bmd, bif, stn, fkp: Aed?
    let egp, ils, gtq, cuc: Aed?
    let cup, crc, gel, zar: Aed?
    let php, dkk, ttd, pln: Aed?
    let kwd, lsl, isk, szl: Aed?
    let mmk, jmd, mad, mru: Aed?
    let etb, gmd, pab, bgn: Aed?
    let mnt, btn, wst, tmt: Aed?
    let kyd, ern, omr, ron: Aed?
    let jep, cdf, sos, clp: Aed?
    let nok: Aed?
    let sdg: BAM?
    let pen, nio, rub, mkd: Aed?
    let krw, afn, ves, gnf: Aed?
    let htg, ars, lbp, currenciesTRY: Aed?
    let kgs, bbd, nad, srd: Aed?
    let lyd, tnd, yer, gip: Aed?
    let jpy, lrd, bwp, kid: Aed?
    let bdt, top, mzn, hnl: Aed?
    let djf, brl, fok, imp: Aed?
    let kzt, rsd, rwf, cop: Aed?
    let myr, all, uah, ckd: Aed?
    let mvr: Aed?

    enum CodingKeys: String, CodingKey {
        case vuv = "VUV"
        case gbp = "GBP"
        case ggp = "GGP"
        case syp = "SYP"
        case eur = "EUR"
        case mwk = "MWK"
        case khr = "KHR"
        case usd = "USD"
        case sbd = "SBD"
        case dop = "DOP"
        case cad = "CAD"
        case uyu = "UYU"
        case xcd = "XCD"
        case byn = "BYN"
        case pkr = "PKR"
        case sar = "SAR"
        case huf = "HUF"
        case lkr = "LKR"
        case bam = "BAM"
        case kpw = "KPW"
        case tzs = "TZS"
        case gyd = "GYD"
        case npr = "NPR"
        case jod = "JOD"
        case iqd = "IQD"
        case sll = "SLL"
        case shp = "SHP"
        case chf = "CHF"
        case pgk = "PGK"
        case mop = "MOP"
        case lak = "LAK"
        case bnd = "BND"
        case sgd = "SGD"
        case tjs = "TJS"
        case irr = "IRR"
        case mga = "MGA"
        case ang = "ANG"
        case azn = "AZN"
        case amd = "AMD"
        case ugx = "UGX"
        case inr = "INR"
        case xpf = "XPF"
        case sek = "SEK"
        case dzd = "DZD"
        case nzd = "NZD"
        case bhd = "BHD"
        case thb = "THB"
        case hkd = "HKD"
        case cve = "CVE"
        case uzs = "UZS"
        case qar = "QAR"
        case ssp = "SSP"
        case ghs = "GHS"
        case bzd = "BZD"
        case twd = "TWD"
        case aud = "AUD"
        case zwl = "ZWL"
        case vnd = "VND"
        case kes = "KES"
        case xaf = "XAF"
        case xof = "XOF"
        case aoa = "AOA"
        case tvd = "TVD"
        case mur = "MUR"
        case idr = "IDR"
        case scr = "SCR"
        case awg = "AWG"
        case ngn = "NGN"
        case fjd = "FJD"
        case zmw = "ZMW"
        case bsd = "BSD"
        case kmf = "KMF"
        case aed = "AED"
        case pyg = "PYG"
        case czk = "CZK"
        case mxn = "MXN"
        case mdl = "MDL"
        case bob = "BOB"
        case cny = "CNY"
        case bmd = "BMD"
        case bif = "BIF"
        case stn = "STN"
        case fkp = "FKP"
        case egp = "EGP"
        case ils = "ILS"
        case gtq = "GTQ"
        case cuc = "CUC"
        case cup = "CUP"
        case crc = "CRC"
        case gel = "GEL"
        case zar = "ZAR"
        case php = "PHP"
        case dkk = "DKK"
        case ttd = "TTD"
        case pln = "PLN"
        case kwd = "KWD"
        case lsl = "LSL"
        case isk = "ISK"
        case szl = "SZL"
        case mmk = "MMK"
        case jmd = "JMD"
        case mad = "MAD"
        case mru = "MRU"
        case etb = "ETB"
        case gmd = "GMD"
        case pab = "PAB"
        case bgn = "BGN"
        case mnt = "MNT"
        case btn = "BTN"
        case wst = "WST"
        case tmt = "TMT"
        case kyd = "KYD"
        case ern = "ERN"
        case omr = "OMR"
        case ron = "RON"
        case jep = "JEP"
        case cdf = "CDF"
        case sos = "SOS"
        case clp = "CLP"
        case nok = "NOK"
        case sdg = "SDG"
        case pen = "PEN"
        case nio = "NIO"
        case rub = "RUB"
        case mkd = "MKD"
        case krw = "KRW"
        case afn = "AFN"
        case ves = "VES"
        case gnf = "GNF"
        case htg = "HTG"
        case ars = "ARS"
        case lbp = "LBP"
        case currenciesTRY = "TRY"
        case kgs = "KGS"
        case bbd = "BBD"
        case nad = "NAD"
        case srd = "SRD"
        case lyd = "LYD"
        case tnd = "TND"
        case yer = "YER"
        case gip = "GIP"
        case jpy = "JPY"
        case lrd = "LRD"
        case bwp = "BWP"
        case kid = "KID"
        case bdt = "BDT"
        case top = "TOP"
        case mzn = "MZN"
        case hnl = "HNL"
        case djf = "DJF"
        case brl = "BRL"
        case fok = "FOK"
        case imp = "IMP"
        case kzt = "KZT"
        case rsd = "RSD"
        case rwf = "RWF"
        case cop = "COP"
        case myr = "MYR"
        case all = "ALL"
        case uah = "UAH"
        case ckd = "CKD"
        case mvr = "MVR"
    }
}

// MARK: - Aed
struct Aed: Codable {
    let name, symbol: String?
}

// MARK: - BAM
struct BAM: Codable {
    let name: String?
}

