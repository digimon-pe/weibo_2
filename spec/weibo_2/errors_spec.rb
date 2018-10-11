require 'helper'
require 'pry'

describe WeiboOAuth2::Errors do
  let(:error_message) { 'There are some error messages here.' }
  let(:data) do
    {
      'error'      => error_message,
      'error_code' => error_code,
      'request'    => ''
    }
  end

  describe '.human_error_message' do
    subject { WeiboOAuth2::Errors::WeiboError.new(data).human_error_message }

    context 'when error_code is 10001' do
      let(:error_code) { 10_001 }

      it { is_expected.to eq '系统错误' }
    end

    context 'when error_code is 10002' do
      let(:error_code) { 10_002 }

      it { is_expected.to eq '服务暂停' }
    end

    context 'when error_code is 10003' do
      let(:error_code) { 10_003 }

      it { is_expected.to eq '远程服务错误' }
    end

    context 'when error_code is 10004' do
      let(:error_code) { 10_004 }

      it { is_expected.to eq 'IP限制不能请求该资源' }
    end

    context 'when error_code is 10005' do
      let(:error_code) { 10_005 }

      it { is_expected.to eq '该资源需要appkey拥有授权' }
    end

    context 'when error_code is 10006' do
      let(:error_code) { 10_006 }

      it { is_expected.to eq '缺少source (appkey) 参数' }
    end

    context 'when error_code is 10007' do
      let(:error_code) { 10_007 }
      let(:error_message) { 'The error has a (column)' }

      it { is_expected.to eq '不支持的MediaType (column)' }
    end

    context 'when error_code is 10008' do
      let(:error_code) { 10_008 }

      it { is_expected.to eq '参数错误，请参考API文档' }
    end

    context 'when error_code is 10009' do
      let(:error_code) { 10_009 }

      it { is_expected.to eq '任务过多，系统繁忙' }
    end

    context 'when error_code is 10010' do
      let(:error_code) { 10_010 }

      it { is_expected.to eq '任务超时' }
    end

    context 'when error_code is 10011' do
      let(:error_code) { 10_011 }

      it { is_expected.to eq 'RPC错误' }
    end

    context 'when error_code is 10012' do
      let(:error_code) { 10_012 }

      it { is_expected.to eq '非法请求' }
    end

    context 'when error_code is 10013' do
      let(:error_code) { 10_013 }

      it { is_expected.to eq '不合法的微博用户' }
    end

    context 'when error_code is 10014' do
      let(:error_code) { 10_014 }

      it { is_expected.to eq '应用的接口访问权限受限' }
    end

    context 'when error_code is 10016' do
      let(:error_code) { 10_016 }
      let(:error_message) { 'There are (some) error messages here.' }

      it { is_expected.to eq '缺失必选参数 (some)，请参考API文档' }
    end

    context 'when error_code is 10017' do
      let(:error_code) { 10_017 }
      let(:error_message) { 'There are (some) (error) messages here.' }

      it { is_expected.to eq '参数值非法，需为 (some)，实际为 (error)，请参考API文档' }
    end

    context 'when error_code is 10018' do
      let(:error_code) { 10_018 }

      it { is_expected.to eq '请求长度超过限制' }
    end

    context 'when error_code is 10020' do
      let(:error_code) { 10_020 }

      it { is_expected.to eq '接口不存在' }
    end

    context 'when error_code is 10021' do
      let(:error_code) { 10_021 }

      it { is_expected.to eq '请求的HTTP METHOD不支持，请检查是否选择了正确的POST/GET方式↵' }
    end

    context 'when error_code is 10022' do
      let(:error_code) { 10_022 }

      it { is_expected.to eq 'IP请求频次超过上限' }
    end

    context 'when error_code is 10023' do
      let(:error_code) { 10_023 }

      it { is_expected.to eq '用户请求频次超过上限' }
    end

    context 'when error_code is 10024' do
      let(:error_code) { 10_024 }
      let(:error_message) { 'There are (some) error messages here.' }

      it { is_expected.to eq '用户请求特殊接口 (some) 频次超过上限' }
    end

    context 'when error_code is 20001' do
      let(:error_code) { 20_001 }

      it { is_expected.to eq 'IDs参数为空' }
    end

    context 'when error_code is 20002' do
      let(:error_code) { 20_002 }

      it { is_expected.to eq 'Uid参数为空' }
    end

    context 'when error_code is 20003' do
      let(:error_code) { 20_003 }

      it { is_expected.to eq '用户不存在' }
    end

    context 'when error_code is 20005' do
      let(:error_code) { 20_005 }

      it { is_expected.to eq '不支持的图片类型，仅仅支持JPG、GIF、PNG' }
    end

    context 'when error_code is 20006' do
      let(:error_code) { 20_006 }

      it { is_expected.to eq '图片太大' }
    end

    context 'when error_code is 20007' do
      let(:error_code) { 20_007 }

      it { is_expected.to eq '请确保使用multpart上传图片' }
    end

    context 'when error_code is 20008' do
      let(:error_code) { 20_008 }

      it { is_expected.to eq '内容为空' }
    end

    context 'when error_code is 20009' do
      let(:error_code) { 20_009 }

      it { is_expected.to eq 'IDs参数太长了' }
    end

    context 'when error_code is 20012' do
      let(:error_code) { 20_012 }

      it { is_expected.to eq '输入文字太长，请确认不超过140个字符' }
    end

    context 'when error_code is 20013' do
      let(:error_code) { 20_013 }

      it { is_expected.to eq '输入文字太长，请确认不超过300个字符' }
    end

    context 'when error_code is 20014' do
      let(:error_code) { 20_014 }

      it { is_expected.to eq '安全检查参数有误，请再调用一次' }
    end

    context 'when error_code is 20015' do
      let(:error_code) { 20_015 }

      it { is_expected.to eq '账号、IP或应用非法，暂时无法完成此操作' }
    end

    context 'when error_code is 20016' do
      let(:error_code) { 20_016 }

      it { is_expected.to eq '发布内容过于频繁' }
    end

    context 'when error_code is 20017' do
      let(:error_code) { 20_017 }

      it { is_expected.to eq '提交相似的信息' }
    end

    context 'when error_code is 20018' do
      let(:error_code) { 20_018 }

      it { is_expected.to eq '包含非法网址' }
    end

    context 'when error_code is 20019' do
      let(:error_code) { 20_019 }

      it { is_expected.to eq '提交相同的信息' }
    end

    context 'when error_code is 20020' do
      let(:error_code) { 20_020 }

      it { is_expected.to eq '包含广告信息' }
    end

    context 'when error_code is 20021' do
      let(:error_code) { 20_021 }

      it { is_expected.to eq '包含非法内容' }
    end

    context 'when error_code is 20022' do
      let(:error_code) { 20_022 }

      it { is_expected.to eq '此IP地址上的行为异常' }
    end

    context 'when error_code is 20031' do
      let(:error_code) { 20_031 }

      it { is_expected.to eq '需要验证码' }
    end

    context 'when error_code is 20032' do
      let(:error_code) { 20_032 }

      it { is_expected.to eq '发布成功，目前服务器可能会有延迟，请耐心等待1-2分钟' }
    end

    context 'when error_code is 20101' do
      let(:error_code) { 20_101 }

      it { is_expected.to eq '不存在的微博' }
    end

    context 'when error_code is 20102' do
      let(:error_code) { 20_102 }

      it { is_expected.to eq '不是你发布的微博' }
    end

    context 'when error_code is 20103' do
      let(:error_code) { 20_103 }

      it { is_expected.to eq '不能转发自己的微博' }
    end

    context 'when error_code is 20104' do
      let(:error_code) { 20_104 }

      it { is_expected.to eq '不合法的微博' }
    end

    context 'when error_code is 20109' do
      let(:error_code) { 20_109 }

      it { is_expected.to eq '微博ID为空' }
    end

    context 'when error_code is 20111' do
      let(:error_code) { 20_111 }

      it { is_expected.to eq '不能发布相同的微博' }
    end

    context 'when error_code is 20201' do
      let(:error_code) { 20_201 }

      it { is_expected.to eq '不存在的微博评论' }
    end

    context 'when error_code is 20202' do
      let(:error_code) { 20_202 }

      it { is_expected.to eq '不合法的评论' }
    end

    context 'when error_code is 20203' do
      let(:error_code) { 20_203 }

      it { is_expected.to eq '不是你发布的评论' }
    end

    context 'when error_code is 20204' do
      let(:error_code) { 20_204 }

      it { is_expected.to eq '评论ID为空' }
    end

    context 'when error_code is 20301' do
      let(:error_code) { 20_301 }

      it { is_expected.to eq '不能给不是你粉丝的人发私信' }
    end

    context 'when error_code is 20302' do
      let(:error_code) { 20_302 }

      it { is_expected.to eq '不合法的私信' }
    end

    context 'when error_code is 20303' do
      let(:error_code) { 20_303 }

      it { is_expected.to eq '不是属于你的私信' }
    end

    context 'when error_code is 20305' do
      let(:error_code) { 20_305 }

      it { is_expected.to eq '不存在的私信' }
    end

    context 'when error_code is 20306' do
      let(:error_code) { 20_306 }

      it { is_expected.to eq '不能发布相同的私信' }
    end

    context 'when error_code is 20307' do
      let(:error_code) { 20_307 }

      it { is_expected.to eq '非法的私信ID' }
    end

    context 'when error_code is 20401' do
      let(:error_code) { 20_401 }

      it { is_expected.to eq '域名不存在' }
    end

    context 'when error_code is 20402' do
      let(:error_code) { 20_402 }

      it { is_expected.to eq 'Verifier错误' }
    end

    context 'when error_code is 20501' do
      let(:error_code) { 20_501 }

      it { is_expected.to eq '参数source_user或者target_user的用户不存在' }
    end

    context 'when error_code is 20502' do
      let(:error_code) { 20_502 }

      it { is_expected.to eq '必须输入目标用户id或者screen_name' }
    end

    context 'when error_code is 20503' do
      let(:error_code) { 20_503 }

      it { is_expected.to eq '参数user_id必须是你关注的用户' }
    end

    context 'when error_code is 20504' do
      let(:error_code) { 20_504 }

      it { is_expected.to eq '你不能关注自己 ' }
    end

    context 'when error_code is 20505' do
      let(:error_code) { 20_505 }

      it { is_expected.to eq '加关注请求超过上限' }
    end

    context 'when error_code is 20506' do
      let(:error_code) { 20_506 }

      it { is_expected.to eq '已经关注此用户' }
    end

    context 'when error_code is 20507' do
      let(:error_code) { 20_507 }

      it { is_expected.to eq '需要输入验证码' }
    end

    context 'when error_code is 20508' do
      let(:error_code) { 20_508 }

      it { is_expected.to eq '根据对方的设置，你不能进行此操作' }
    end

    context 'when error_code is 20509' do
      let(:error_code) { 20_509 }

      it { is_expected.to eq '悄悄关注个数到达上限 ' }
    end

    context 'when error_code is 20510' do
      let(:error_code) { 20_510 }

      it { is_expected.to eq '不是悄悄关注人' }
    end

    context 'when error_code is 20511' do
      let(:error_code) { 20_511 }

      it { is_expected.to eq '已经悄悄关注此用户' }
    end

    context 'when error_code is 20512' do
      let(:error_code) { 20_512 }

      it { is_expected.to eq '你已经把此用户加入黑名单，加关注前请先解除' }
    end

    context 'when error_code is 20513' do
      let(:error_code) { 20_513 }

      it { is_expected.to eq '你的关注人数已达上限' }
    end

    context 'when error_code is 20521' do
      let(:error_code) { 20_521 }

      it { is_expected.to eq 'hi 超人，你今天已经关注很多喽，接下来的时间想想如何让大家都来关注你吧！如有问题，请联系新浪客服：400 690 0000' }
    end

    context 'when error_code is 20522' do
      let(:error_code) { 20_522 }

      it { is_expected.to eq '还未关注此用户' }
    end

    context 'when error_code is 20523' do
      let(:error_code) { 20_523 }

      it { is_expected.to eq '还不是粉丝' }
    end

    context 'when error_code is 20524' do
      let(:error_code) { 20_524 }

      it { is_expected.to eq 'hi 超人，你今天已经取消关注很多喽，接下来的时间想想如何让大家都来关注你吧！如有问题，请联系新浪客服：400 690 0000' }
    end

    context 'when error_code is 20601' do
      let(:error_code) { 20_601 }

      it { is_expected.to eq '列表名太长，请确保输入的文本不超过10个字符' }
    end

    context 'when error_code is 20602' do
      let(:error_code) { 20_602 }

      it { is_expected.to eq '列表描叙太长，请确保输入的文本不超过70个字符' }
    end

    context 'when error_code is 20603' do
      let(:error_code) { 20_603 }

      it { is_expected.to eq '列表不存在' }
    end

    context 'when error_code is 20604' do
      let(:error_code) { 20_604 }

      it { is_expected.to eq '不是列表的所属者' }
    end

    context 'when error_code is 20605' do
      let(:error_code) { 20_605 }

      it { is_expected.to eq '列表名或描叙不合法' }
    end

    context 'when error_code is 20606' do
      let(:error_code) { 20_606 }

      it { is_expected.to eq '记录已存在' }
    end

    context 'when error_code is 20607' do
      let(:error_code) { 20_607 }

      it { is_expected.to eq '数据库错误，请联系系统管理员' }
    end

    context 'when error_code is 20608' do
      let(:error_code) { 20_608 }

      it { is_expected.to eq '列表名冲突' }
    end

    context 'when error_code is 20610' do
      let(:error_code) { 20_610 }

      it { is_expected.to eq '目前不支持私有分组' }
    end

    context 'when error_code is 20611' do
      let(:error_code) { 20_611 }

      it { is_expected.to eq '创建列表失败' }
    end

    context 'when error_code is 20612' do
      let(:error_code) { 20_612 }

      it { is_expected.to eq '目前只支持私有分组' }
    end

    context 'when error_code is 20613' do
      let(:error_code) { 20_613 }

      it { is_expected.to eq '订阅列表达到上限' }
    end

    context 'when error_code is 20614' do
      let(:error_code) { 20_614 }

      it { is_expected.to eq '创建列表达到上限，请参考API文档' }
    end

    context 'when error_code is 20615' do
      let(:error_code) { 20_615 }

      it { is_expected.to eq '列表成员上限，请参考API文档' }
    end

    context 'when error_code is 20701' do
      let(:error_code) { 20_701 }

      it { is_expected.to eq '不能提交相同的收藏标签' }
    end

    context 'when error_code is 20702' do
      let(:error_code) { 20_702 }

      it { is_expected.to eq '最多两个收藏标签' }
    end

    context 'when error_code is 20703' do
      let(:error_code) { 20_703 }

      it { is_expected.to eq '收藏标签名不合法' }
    end

    context 'when error_code is 20801' do
      let(:error_code) { 20_801 }

      it { is_expected.to eq '参数trend_name是空值' }
    end

    context 'when error_code is 20802' do
      let(:error_code) { 20_802 }

      it { is_expected.to eq '参数trend_id是空值' }
    end

    context 'when error_code is 20901' do
      let(:error_code) { 20_901 }

      it { is_expected.to eq '错误:已经添加了黑名单' }
    end

    context 'when error_code is 20902' do
      let(:error_code) { 20_902 }

      it { is_expected.to eq '错误:已达到黑名单上限' }
    end

    context 'when error_code is 20903' do
      let(:error_code) { 20_903 }

      it { is_expected.to eq '错误:不能添加系统管理员为黑名单' }
    end

    context 'when error_code is 20904' do
      let(:error_code) { 20_904 }

      it { is_expected.to eq '错误:不能添加自己为黑名单' }
    end

    context 'when error_code is 20905' do
      let(:error_code) { 20_905 }

      it { is_expected.to eq '错误:不在黑名单中' }
    end

    context 'when error_code is 21001' do
      let(:error_code) { 21_001 }

      it { is_expected.to eq '标签参数为空' }
    end

    context 'when error_code is 21002' do
      let(:error_code) { 21_002 }

      it { is_expected.to eq '标签名太长，请确保每个标签名不超过14个字符' }
    end

    context 'when error_code is 21101' do
      let(:error_code) { 21_101 }

      it { is_expected.to eq '参数domain错误' }
    end

    context 'when error_code is 21102' do
      let(:error_code) { 21_102 }

      it { is_expected.to eq '该手机号已经被使用' }
    end

    context 'when error_code is 21103' do
      let(:error_code) { 21_103 }

      it { is_expected.to eq '该用户已经绑定手机' }
    end

    context 'when error_code is 21104' do
      let(:error_code) { 21_104 }

      it { is_expected.to eq 'Verifier错误' }
    end

    context 'when error_code is 21301' do
      let(:error_code) { 21_301 }

      it { is_expected.to eq '认证失败' }
    end

    context 'when error_code is 21302' do
      let(:error_code) { 21_302 }

      it { is_expected.to eq '用户名或密码不正确' }
    end

    context 'when error_code is 21303' do
      let(:error_code) { 21_303 }

      it { is_expected.to eq '用户名密码认证超过请求限制' }
    end

    context 'when error_code is 21304' do
      let(:error_code) { 21_304 }

      it { is_expected.to eq '版本号错误' }
    end

    context 'when error_code is 21305' do
      let(:error_code) { 21_305 }

      it { is_expected.to eq '缺少必要的参数' }
    end

    context 'when error_code is 21306' do
      let(:error_code) { 21_306 }

      it { is_expected.to eq 'OAuth参数被拒绝' }
    end

    context 'when error_code is 21307' do
      let(:error_code) { 21_307 }

      it { is_expected.to eq '时间戳不正确' }
    end

    context 'when error_code is 21308' do
      let(:error_code) { 21_308 }

      it { is_expected.to eq '参数nonce已经被使用' }
    end

    context 'when error_code is 21309' do
      let(:error_code) { 21_309 }

      it { is_expected.to eq '签名算法不支持' }
    end

    context 'when error_code is 21310' do
      let(:error_code) { 21_310 }

      it { is_expected.to eq '签名值不合法' }
    end

    context 'when error_code is 21311' do
      let(:error_code) { 21_311 }

      it { is_expected.to eq '参数consumer_key不存在' }
    end

    context 'when error_code is 21312' do
      let(:error_code) { 21_312 }

      it { is_expected.to eq '参数consumer_key不合法' }
    end

    context 'when error_code is 21313' do
      let(:error_code) { 21_313 }

      it { is_expected.to eq '参数consumer_key缺失' }
    end

    context 'when error_code is 21314' do
      let(:error_code) { 21_314 }

      it { is_expected.to eq 'Token已经被使用' }
    end

    context 'when error_code is 21315' do
      let(:error_code) { 21_315 }

      it { is_expected.to eq 'Token已经过期' }
    end

    context 'when error_code is 21316' do
      let(:error_code) { 21_316 }

      it { is_expected.to eq 'Token不合法' }
    end

    context 'when error_code is 21317' do
      let(:error_code) { 21_317 }

      it { is_expected.to eq 'Token不合法' }
    end

    context 'when error_code is 21318' do
      let(:error_code) { 21_318 }

      it { is_expected.to eq 'Pin码认证失败' }
    end

    context 'when error_code is 21319' do
      let(:error_code) { 21_319 }

      it { is_expected.to eq '授权关系已经被解除' }
    end

    context 'when error_code is 21320' do
      let(:error_code) { 21_320 }

      it { is_expected.to eq '使用OAuth2必须使用https' }
    end

    context 'when error_code is 21321' do
      let(:error_code) { 21_321 }

      it { is_expected.to eq '未审核的应用使用人数超过限制' }
    end

    context 'when error_code is 21327' do
      let(:error_code) { 21_327 }

      it { is_expected.to eq 'token过期' }
    end

    context 'when error_code is 21335' do
      let(:error_code) { 21_335 }

      it { is_expected.to eq 'uid参数仅允许传入当前授权用户uid' }
    end

    context 'when error_code is 21501' do
      let(:error_code) { 21_501 }

      it { is_expected.to eq '参数urls是空的' }
    end

    context 'when error_code is 21502' do
      let(:error_code) { 21_502 }

      it { is_expected.to eq '参数urls太多了' }
    end

    context 'when error_code is 21503' do
      let(:error_code) { 21_503 }

      it { is_expected.to eq 'IP是空值' }
    end

    context 'when error_code is 21504' do
      let(:error_code) { 21_504 }

      it { is_expected.to eq '参数url是空值' }
    end

    context 'when error_code is 21601' do
      let(:error_code) { 21_601 }

      it { is_expected.to eq '需要系统管理员的权限' }
    end

    context 'when error_code is 21602' do
      let(:error_code) { 21_602 }

      it { is_expected.to eq '含有敏感词' }
    end

    context 'when error_code is 21603' do
      let(:error_code) { 21_603 }

      it { is_expected.to eq '通知发送达到限制' }
    end

    context 'when error_code is 21701' do
      let(:error_code) { 21_701 }

      it { is_expected.to eq '提醒失败，需要权限' }
    end

    context 'when error_code is 21702' do
      let(:error_code) { 21_702 }

      it { is_expected.to eq '无效分类' }
    end

    context 'when error_code is 21703' do
      let(:error_code) { 21_703 }

      it { is_expected.to eq '无效状态码' }
    end

    context 'when error_code is 21901' do
      let(:error_code) { 21_901 }

      it { is_expected.to eq '地理信息输入错误' }
    end
  end
end
