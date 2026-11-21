# 韩系衣橱 · Korean Edit

给中国用户逛韩国时尚品牌的中文入口。包含 MUSINSA、SSF SHOP、8SECONDS、29CM、W CONCEPT、ZIGZAG。

## 站点
- GitHub 仓库：https://github.com/liuyanbingispretty-arch/kstyle-zh-portal
- 发布后的站点预期地址：https://liuyanbingispretty-arch.github.io/kstyle-zh-portal/
- 现有功能：韩系品牌导航、跳转 Google 网页翻译尝试中文浏览、原站链接、按设备本地收藏、韩元与人民币手工参考汇率估算。
- 本网站不会直接修改韩国商家的页面，不是跨站购物结算系统，不负责商家账号登录。

## GitHub Pages 正式上线操作（一次即可）
1. 打开：https://github.com/liuyanbingispretty-arch/kstyle-zh-portal/settings/pages
2. 找到 **Build and deployment → Source**，选择 **GitHub Actions**，不必再生成新工作流：仓库已包含 `.github/workflows/pages.yml`。
3. 打开：https://github.com/liuyanbingispretty-arch/kstyle-zh-portal/actions
4. 如果自动部署因首次 Pages 未开启而失败，进入 **Publish Korean Edit website** 工作流，点击 **Run workflow**，使用 `main` 分支运行。
5. 运行成功后在 Pages 设置页查看 **Visit site**，网址一般是 https://liuyanbingispretty-arch.github.io/kstyle-zh-portal/。

之后推送至 `main` 会自动更新网站。

## 要真正支持注册登录和多设备同步收藏（仍需 Supabase）
> 目前没有连接 Supabase，因此注册和邮箱登录暂不能使用。不要输入韩国购物网站的登录密码到本网站。

1. 在 https://supabase.com/ 新建项目。
2. 从项目设置中复制 Project URL 和 **publishable/anon key**（它们是公开客户端参数）。
3. 将仓库根目录的 `schema.sql` 粘贴至 Supabase SQL Editor 运行，启用有 RLS 的个人收藏表。
4. 在 Supabase Authentication 中启用 Email 登录，并将 Site URL 和 Redirect URLs 设置为此站的 GitHub Pages URL。
5. 编辑仓库里的 `config.js`：只填 `supabaseUrl`、`supabaseAnonKey`。
6. 保存后网站自动重新部署，注册与登录功能才可用。

千万不要把 Supabase **service_role key**、私密 API key、邮箱密码、个人购物账号凭据上传到 GitHub。

## 中文翻译的限制
- **中文浏览**通过 Google 网页翻译代理服务跳转，不是自建翻译引擎，不能保证实时、完整翻译动态商家网页。
- 部分网站阻止代理翻译，可能出现页面打不开、翻译后不能登录、购物车错误等情况。
- 在中国大陆网络可能无法使用 Google 翻译，建议在原官网使用 Safari/Chrome 浏览器自带的网页翻译功能。
- 请只在韩国品牌**官方原站**输入账号、支付与验证码。

## 相关文件
- `index.html`：中文导航网站
- `config.js`：可选 Supabase 公开配置
- `schema.sql`：收藏表及每人独立访问的数据库 RLS
- `.github/workflows/pages.yml`：GitHub Pages 自动发布
