//
//  ServiceHeaders.swift
//  BzzChater


import UIKit
import Foundation

var BASE_URL : String                           = EsaadConfiguration.shared.baseURL
var BASE_URL_FOR_USER_AUTHENTICATION : String   = EsaadConfiguration.shared.authBaseURL


var LOGIN               = "login"
var ENGLISH_SERVICE     = "en/"
var ARABIC_SERVICE      = "ar/"

func ADD_USER_ID() -> String{

    return ""
}

var CODE_ERROR_FOR_LOGOUT           = 401

var GET_CATEGORIES                  = "categories"
var GET_SUBCATEGORIES               = "sub"
var DEAL_DROPDOWN                   = "/deals/dropdown"
var SUB_CATEGORY                    = "categories/sub/"
var DEALS_DROPDOWN                  = "/deals/dropdown"
var GET_DEALS                       = "deals"
var FILTER_CATEGORIES_LISTING       = "categories/listing"
var NEARBY_DEALS                    = "nearby/map/deals"
var GET_BRANCHES_FOR_DEAL           = "deals/branch/category"
var GET_REVIEWLISTING               = "/reviewListing"
var SET_REVIEWS                     = "deals/setReview"
var GET_DASHBOARD_DEALS             = "dashboard/deals"
var Mark_DEAL_FAVORITE              = "deal/markFavourite"
var MAP_DEALS                       = "map/deals/sub"
var DEAL_DETAILS                    = "dealDetail/"
var SAVE_PROFILE                    = "profile/new"
var SAVE_PROFILE_NEW                = "profile"
var FAV_LISTING                     = "deals/favourite"
var GET_DEPARTMENTS                 = "departments"
var REGISTER_USER                   = "users/add"
var FORGOT_PASSWORD                 = "password/forgot"
var CHANGE_PASSWORD                 = "password/change"
var GET_FEEDBACK_TYPES              = "feedbacks/types"
var ADD_FEEDBACK                    = "feedbacks/add"
var VALIDATE_BARCODE                = "user/redeem/verification"
var AVAIL_DEAL                      = "user/avail/deal"
var GET_COMPANIES                   = "companies"
var VALIDATE_REGISTRATION_BARCODE   = "employee/verification"
var GET_COUNTRIES                   = "availableDeals/countries"
var GET_CITIES                      = "availableDeals/country/"
var GET_MALLS                       = "malls/list"
var GET_CITY                        = "/cities"
var GET_USER                        = "auth/users"
var GET_AVAIL_DEALS                 = "/availed/deals"
var GET_SOLD_DEALS                  = "/sold/deals"
var NEWS                            = "news"
var MAP_DEAL_DETAILS                = "news"
var GET_CONTACTUS                   = "/contactUs"
var GET_CONTENT                     = "content?contentType="
var GET_CONTENT_ABOUT               = "ABOUT_US"
var GET_CONTENT_BgImage             = "BACKGROUND_IMAGE"
var GET_CONTENT_PRIVACY             = "PRIVACY_POLICY"
var GET_CONTENT_TERMS               = "TERMS_CONDITION"
var GET_ABOUTUS_PARTNERS            = "partners"
var GET_ABOUTUS_COMMITMENT          = "COMMITMENT"
var GET_VISITORCOUNT                = "visits"
var ADD_VISIT                       = "visit/add"
var GET_USER_DETAIL                 = "user/detail/"
var EMAIL_VERIFICATION              = "email/verification"
var CONFIG_NOTIFICATION             = "notification/device"
var GET_BRANCHES                    = "dealBranches"
var PUSH_USERLOC                    = "/deals/nearest"
