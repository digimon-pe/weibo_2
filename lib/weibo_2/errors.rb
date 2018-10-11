module WeiboOAuth2
  module Errors
    class WeiboError < StandardError
      extend Forwardable
      def_delegators :data, :error_code, :error, :request
      attr_reader :data
      def initialize(data)
        @data = Hashie::Mash.new data
        super
      end

      def human_error_message
        case error_code
        when 10_001 then '系统错误'
        when 10_002 then '服务暂停'
        when 10_003 then '远程服务错误'
        when 10_004 then 'IP限制不能请求该资源'
        when 10_005 then '该资源需要appkey拥有授权'
        when 10_006 then '缺少source (appkey) 参数'
        when 10_007 then '不支持的MediaType (%s)' % human_error_message_placeholder
        when 10_008 then '参数错误，请参考API文档'
        when 10_009 then '任务过多，系统繁忙'
        when 10_010 then '任务超时'
        when 10_011 then 'RPC错误'
        when 10_012 then '非法请求'
        when 10_013 then '不合法的微博用户'
        when 10_014 then '应用的接口访问权限受限'
        when 10_016 then '缺失必选参数 (%s)，请参考API文档' % human_error_message_placeholder
        when 10_017 then '参数值非法，需为 (%s)，实际为 (%s)，请参考API文档' % human_error_message_placeholder
        when 10_018 then '请求长度超过限制'
        when 10_020 then '接口不存在'
        when 10_021 then '请求的HTTP METHOD不支持，请检查是否选择了正确的POST/GET方式↵'
        when 10_022 then 'IP请求频次超过上限'
        when 10_023 then '用户请求频次超过上限'
        when 10_024 then '用户请求特殊接口 (%s) 频次超过上限' % human_error_message_placeholder
        when 20_001 then 'IDs参数为空'
        when 20_002 then 'Uid参数为空'
        when 20_003 then '用户不存在'
        when 20_005 then '不支持的图片类型，仅仅支持JPG、GIF、PNG'
        when 20_006 then '图片太大'
        when 20_007 then '请确保使用multpart上传图片'
        when 20_008 then '内容为空'
        when 20_009 then 'IDs参数太长了'
        when 20_012 then '输入文字太长，请确认不超过140个字符'
        when 20_013 then '输入文字太长，请确认不超过300个字符'
        when 20_014 then '安全检查参数有误，请再调用一次'
        when 20_015 then '账号、IP或应用非法，暂时无法完成此操作'
        when 20_016 then '发布内容过于频繁'
        when 20_017 then '提交相似的信息'
        when 20_018 then '包含非法网址'
        when 20_019 then '提交相同的信息'
        when 20_020 then '包含广告信息'
        when 20_021 then '包含非法内容'
        when 20_022 then '此IP地址上的行为异常'
        when 20_031 then '需要验证码'
        when 20_032 then '发布成功，目前服务器可能会有延迟，请耐心等待1-2分钟'
        when 20_101 then '不存在的微博'
        when 20_102 then '不是你发布的微博'
        when 20_103 then '不能转发自己的微博'
        when 20_104 then '不合法的微博'
        when 20_109 then '微博ID为空'
        when 20_111 then '不能发布相同的微博'
        when 20_201 then '不存在的微博评论'
        when 20_202 then '不合法的评论'
        when 20_203 then '不是你发布的评论'
        when 20_204 then '评论ID为空'
        when 20_301 then '不能给不是你粉丝的人发私信'
        when 20_302 then '不合法的私信'
        when 20_303 then '不是属于你的私信'
        when 20_305 then '不存在的私信'
        when 20_306 then '不能发布相同的私信'
        when 20_307 then '非法的私信ID'
        when 20_401 then '域名不存在'
        when 20_402 then 'Verifier错误'
        when 20_501 then '参数source_user或者target_user的用户不存在'
        when 20_502 then '必须输入目标用户id或者screen_name'
        when 20_503 then '参数user_id必须是你关注的用户'
        when 20_504 then '你不能关注自己 '
        when 20_505 then '加关注请求超过上限'
        when 20_506 then '已经关注此用户'
        when 20_507 then '需要输入验证码'
        when 20_508 then '根据对方的设置，你不能进行此操作'
        when 20_509 then '悄悄关注个数到达上限 '
        when 20_510 then '不是悄悄关注人'
        when 20_511 then '已经悄悄关注此用户'
        when 20_512 then '你已经把此用户加入黑名单，加关注前请先解除'
        when 20_513 then '你的关注人数已达上限'
        when 20_521 then 'hi 超人，你今天已经关注很多喽，接下来的时间想想如何让大家都来关注你吧！如有问题，请联系新浪客服：400 690 0000'
        when 20_522 then '还未关注此用户'
        when 20_523 then '还不是粉丝'
        when 20_524 then 'hi 超人，你今天已经取消关注很多喽，接下来的时间想想如何让大家都来关注你吧！如有问题，请联系新浪客服：400 690 0000'
        when 20_601 then '列表名太长，请确保输入的文本不超过10个字符'
        when 20_602 then '列表描叙太长，请确保输入的文本不超过70个字符'
        when 20_603 then '列表不存在'
        when 20_604 then '不是列表的所属者'
        when 20_605 then '列表名或描叙不合法'
        when 20_606 then '记录已存在'
        when 20_607 then '数据库错误，请联系系统管理员'
        when 20_608 then '列表名冲突'
        when 20_610 then '目前不支持私有分组'
        when 20_611 then '创建列表失败'
        when 20_612 then '目前只支持私有分组'
        when 20_613 then '订阅列表达到上限'
        when 20_614 then '创建列表达到上限，请参考API文档'
        when 20_615 then '列表成员上限，请参考API文档'
        when 20_701 then '不能提交相同的收藏标签'
        when 20_702 then '最多两个收藏标签'
        when 20_703 then '收藏标签名不合法'
        when 20_801 then '参数trend_name是空值'
        when 20_802 then '参数trend_id是空值'
        when 20_901 then '错误:已经添加了黑名单'
        when 20_902 then '错误:已达到黑名单上限'
        when 20_903 then '错误:不能添加系统管理员为黑名单'
        when 20_904 then '错误:不能添加自己为黑名单'
        when 20_905 then '错误:不在黑名单中'
        when 21_001 then '标签参数为空'
        when 21_002 then '标签名太长，请确保每个标签名不超过14个字符'
        when 21_101 then '参数domain错误'
        when 21_102 then '该手机号已经被使用'
        when 21_103 then '该用户已经绑定手机'
        when 21_104 then 'Verifier错误'
        when 21_301 then '认证失败'
        when 21_302 then '用户名或密码不正确'
        when 21_303 then '用户名密码认证超过请求限制'
        when 21_304 then '版本号错误'
        when 21_305 then '缺少必要的参数'
        when 21_306 then 'OAuth参数被拒绝'
        when 21_307 then '时间戳不正确'
        when 21_308 then '参数nonce已经被使用'
        when 21_309 then '签名算法不支持'
        when 21_310 then '签名值不合法'
        when 21_311 then '参数consumer_key不存在'
        when 21_312 then '参数consumer_key不合法'
        when 21_313 then '参数consumer_key缺失'
        when 21_314 then 'Token已经被使用'
        when 21_315 then 'Token已经过期'
        when 21_316 then 'Token不合法'
        when 21_317 then 'Token不合法'
        when 21_318 then 'Pin码认证失败'
        when 21_319 then '授权关系已经被解除'
        when 21_320 then '使用OAuth2必须使用https'
        when 21_321 then '未审核的应用使用人数超过限制'
        when 21_327 then 'token过期'
        when 21_335 then 'uid参数仅允许传入当前授权用户uid'
        when 21_501 then '参数urls是空的'
        when 21_502 then '参数urls太多了'
        when 21_503 then 'IP是空值'
        when 21_504 then '参数url是空值'
        when 21_601 then '需要系统管理员的权限'
        when 21_602 then '含有敏感词'
        when 21_603 then '通知发送达到限制'
        when 21_701 then '提醒失败，需要权限'
        when 21_702 then '无效分类'
        when 21_703 then '无效状态码'
        when 21_901 then '地理信息输入错误'
        else error
        end
      rescue ArgumentError
        error
      end

      private

      def human_error_message_placeholder
        error.scan(/\(\w*\)/).map { |match| match.gsub(/(\(|\))/, '') }
      end
    end

    class GeneralError < WeiboError; end
    class RateLimitedError < WeiboError; end
    class UnauthorizedError < WeiboError; end
    class PermissionError < WeiboError; end
  end
end
