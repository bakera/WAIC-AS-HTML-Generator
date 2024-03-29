<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml" version="1.0">
<xsl:output
 method="xml"
 indent="yes" 
 doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN"
 doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"
/>

<xsl:template match="/">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ja" lang="ja">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="robots" content="index, follow" />
<meta name="keywords" content="ウェブ,アクセシビリティ,基盤,委員会,WAIC,web,accessibility,infrastructure,committee,アクセシビリティ,サポーテッド,AS,情報" />
<meta name="description" content="アクセシビリティ・サポーテッド（AS）情報に関する解説文書" />
<link rel="stylesheet" type="text/css" href="http://www.ciaj.or.jp/access/web/cmn/css/docs.css" />
<title>アクセシビリティ・サポーテッド（AS）情報：2012年5月版 <xsl:value-of select="/AsDescription/@target" /></title>
<style type="text/css">table{empty-cells: show;}tr.warn{background: #ffd;}tr.ng{background: #fdd;}</style>
</head>
<body>
<div id="logo"><a href="http://www.ciaj.or.jp/access/web/"><img src="http://www.ciaj.or.jp/access/web/cmn/img/header/logo.png" alt="ウェブアクセシビリティ基盤委員会 / WAIC: Web Accessibility Infrastructure Committee" width="334" height="77" /></a></div>
<h1>アクセシビリティ・サポーテッド（AS）情報：2012年5月版</h1>

<ul>
<li>公開日：2012年5月15日</li>
<li>作成者：ウェブアクセシビリティ基盤委員会（WAIC）実装ワーキンググループ（WG2）</li>
<li>前のバージョン：<a href="/access/web/docs/jis2010-as-understanding/201107/">2011年7月版（2011年8月2日公開）</a></li>
</ul>

<h2>1. はじめに</h2>

<p>この文書は、アクセシビリティ・サポーテッド情報に関する解説文書である。ウェブコンテンツの設計・開発に関わる者が、それぞれの実装方法がアクセ
シビリティ・サポーテッドであるかどうか、つまり達成基準を満たすことのできる実装方法であるかどうかを判断するための参考に用いることができる。</p>

<h2>2. 「アクセシビリティ・サポーテッド」の定義</h2>

<p>JIS X 8341-3:2010では、「6.2 設計」の「b) 使用するウェブコンテンツ技術及び実装方法」で次のような要求事項がある。</p>
<blockquote class="box1">
<p>（略）箇条7 
の達成基準を満たすためには，使用するウェブコンテンツ技術及び実装方法が実際に利用者にとって利用可能であることを確認しなければならない。例えば，仕
様上は定められているがユーザエージェント（ウェブブラウザ，支援技術など）がサポートしていない方法で実装しても，達成基準を満たしているとはいえな
い。</p>
<p>使用するウェブコンテンツ技術の実装方法が達成基準を満たすことができるかどうかを確認することは，設計・開発する者の責任である。</p>
</blockquote>
<p>つまり、「アクセシビリティ・サポーテッド」であるというのは、言い換えると「実際に利用者にとって利用可能」であるという意味である。「アクセシ
ビリティ・サポーテッド」の用語定義や詳細な解説は、JIS X 8341-3:2010の規格票や「WCAG 2.0 
解説書」（"Understanding WCAG 2.0" の日本語訳）を参照のこと。</p>
<ul>
<li>JIS X 8341-3:2010「附属書A（参考）この規格を満たすウェブコンテンツ技術及びその実装方法の選び方」</li>
<li><a href="http://waic.jp/docs/UNDERSTANDING-WCAG20/conformance.html#uc-accessibility-support-head">アクセシビリティ・サポーテッドを理解する｜WCAG 2.0 解説書</a></li>
<li><a href="http://waic.jp/docs/UNDERSTANDING-WCAG20/appendixB.html">附録 B ウェブコンテンツ技術の使用法のアクセシビリティ・サポートを文書化する｜WCAG 2.0 解説書</a></li>
</ul>
<p>また、「使用するウェブコンテンツ技術の実装方法が達成基準を満たすことができるかどうかを確認することは，設計・開発する者の責任である。」とあ
る。それを確認することをできるかぎり容易にするために、ウェブアクセシビリティ基盤委員会（WAIC）では、テストファイルを作成し、ブラウザや支援技
術による独自の検証を行って、その結果を公開している。なお、これらの検証結果について、各実装方法の提供者は何の責務も負わない。</p>

<h2>3. 「アクセシビリティ・サポーテッド」であるかどうかの判断</h2>

<h3>3-1. 達成基準の意図を正しく理解する</h3>

<p>実装方法を検討する前に、まず「6.2 設計」の「a) 
適用する達成基準」で選択した達成基準の意図を正しく理解することが重要である。その達成基準がどのようなユーザーに対してどのようなメリットを提供する
ものであるかを理解していなければ、適切な実装方法を選ぶことはできないからである。</p>
<p>各達成基準の意図を理解するには、「WCAG 2.0 解説書」を参照するとよい。「WCAG 2.0 
解説書」では、それぞれの達成基準の意図を解説しており、その達成基準を満たすことによってどのようなユーザーがどのようなメリットを得ることができるか
について確認することができる。</p>

<h4>例：「7.2.4.1 ブロックスキップに関する達成基準」（等級A）の場合</h4>

<p>例えば、「7.2.4.1 ブロックスキップに関する達成基準」の意図を確認する際には、<a href="http://waic.jp/docs/UNDERSTANDING-WCAG20/navigation-mechanisms-skip.html">WCAG 2.0 解説書「ブロック・スキップ：達成基準 2.4.1 を理解する」</a>を
参照する。「この達成基準の意図」と「達成基準 2.4.1 
の具体的なメリット」を読むと、この達成基準は、主にスクリーンリーダーの利用者、キーボード又はキーボード・インタフェースだけを使用している利用者、
そして画面拡大ソフトを使用している利用者が、ウェブページのメインコンテンツへ素早くかつ容易に到達できるようにすることを意図していることがわかる。</p>

<h3>3-2. 各実装方法がアクセシビリティ・サポーテッドであるかどうかを判断する</h3>

<p>確認した達成基準の意図をふまえて、その達成基準を満たすことのできる実装方法を選択しなければならない。達成基準を満たすことのできる実装方法
は、その多くが「WCAG 2.0 解説書」で挙げられている。ただし、「WCAG 2.0 
解説書」の「達成基準を満たすことのできる実装方法」で挙げられている実装方法は、必ずしも全てがアクセシビリティ・サポーテッドであるとはいえないこと
に注意しなければならない。</p>
<p>実装方法を選択するにあたっては、「アクセシビリティ・サポーテッド検証結果」を参照して、各実装方法の検証結果を確認し、アクセシビリティ・サ
ポーテッドであるかどうかを判断する。なお、「WCAG 2.0 
解説書」の「達成基準を満たすことのできる実装方法」で挙げられている実装方法の中にはブラウザや支援技術によるサポート状況を考慮する必要がないものも
含まれており、それらは検証の対象外となっている。そのため、「WCAG 2.0 
解説書」で挙げられている実装方法のうち、検証結果の一覧表にない実装方法については、アクセシビリティ・サポーテッドであるかどうかを判断する必要は低
いと考えられる。</p>

<h2>4. 判断する際の注意点</h2>

<h3>4-1. 最新の「アクセシビリティ・サポーテッド検証結果」を参照する</h3>

<p>「<a href="http://waic.jp/docs/jis2010/as.html">アクセシビリティ・サポーテッド検証結果</a>」は、必要に応じて随時更新されていく予定である。アクセシビリティ・サポーテッドであるかどうかを判断する際には、その時点での最新の検証結果を参照すること。なお、本文書を作成している時点での最新版は2010年8月版である。</p>

<h3>4-2. 検証結果が全て「○」となっている実装方法</h3>

<p>検証結果が全て「○」となっている実装方法は、アクセシビリティ・サポーテッドであると判断する際の参考として用いることができる。</p>

<p>ただし、「アクセシビリティ・サポーテッド検証結果」は、ウェブアクセシビリティ基盤委員会（WAIC）が選定した主要なOSとユーザーエージェント（ブラウザ及び支援技術）の組合せによる検証結果であり、それ以外の利用環境を想定すべき場合には「<a href="http://waic.jp/docs/jis2010/as-tests.html">AS情報を作成する際に必要となるテストファイル</a>」等を用いて、各自で検証を行う必要がある。</p>

<h3>4-3. 検証結果に「△」または「×」が含まれている実装方法</h3>

<p>4-2以外の場合でその実装方法がアクセシビリティ・サポーテッドであるかどうかの判断を求められるのは、検証結果に「△（一部サポート）」や「×（サポートなし）」が含まれている場合である。</p>

<p>その場合には、想定する閲覧環境（利用者が使用しているブラウザ及び支援技術）をもとに、どのブラウザ及び支援技術の製品とバージョンを重視すべきかを考慮に入れるとよい。</p>
<p>例えば、想定する閲覧環境を変更できる場合は、一般的な統計データやアクセスログなどを参考にすることができる。また、変更できない場合には、既定の想定する閲覧環境をもとに検討するとよい。</p>
<dl>
<dt>一般的な統計データ（参考）</dt>
<dd>
<ul>
<li>ブラウザの利用状況：<a href="http://gs.statcounter.com/">StatCounter Global Stats</a></li>
</ul>
</dd>
<dt>支援技術の利用状況</dt>
<dd>
<ul>
<li>日本語：<a href="http://www.nise.go.jp/kenshuka/josa/kankobutsu/pub_d/d-267.html">視覚障害者のパソコン・インターネット・携帯電話利用状況調査 2007</a></li>
<li>英語圏：<a href="http://webaim.org/projects/screenreadersurvey2/">Screen Reader User Survey Results（WebAIM）</a></li>
</ul>
</dd>
</dl>

<h2>5. 達成基準ごとの解説</h2>

<p>ウェブアクセシビリティ基盤委員会（WAIC）実装ワーキンググループ（WG2）では、「<a href="file:///access/web/docs/jis2010/as.html">アクセシビリティ・サポーテッド検証結果　2010年8月版</a>」をもとに、それぞれの達成基準を満たすことのできる実装方法についての解説を作成した。なお、検証結果において全てのブラウザおよび支援技術によってサポートされている実装方法（前述の「4-2. 検証結果が全て「○」となっている実装方法」を参照）は、解説を作成していない。</p>

<p>なお、JIS X 8341-3:2010の規格票（「6.3 制作・開発」の注記）にも明記されているように、「WCAG 2.0実装方法集」にはない方法もアクセシビリティ・サポーテッドであると判断できるものは用いてもよい。</p>
<blockquote class="box1">
<p><b>6.3 制作・開発</b><br />
<b>注記</b> 達成基準を満たすために用いる（ウェブコンテンツ技術の）実装方法は，W3C が公開しているUnderstanding WCAG 2.0 のSufficient and Advisory Techniques を参照するとよい。実装方法を独自に開発してもよいが，利用者が使用するユーザエージェントを用いて，利用者が問題なく利用可能であることを確認できた場合に限る。</p>
</blockquote>

<h3>解説の前提</h3>

<p>解説を作成するにあたっては、以下の2つを前提としている。これらの前提に合致しないウェブコンテンツに対しては、各自が判断する必要がある。</p>
<ul>
<li>具体的なイメージとして、地方自治体のウェブサイトを想定する。つまり、できるかぎり多くの利用者の閲覧環境をカバーしたいサイトを前提とする。</li>
<li>達成基準ごとに、アクセシビリティ・サポーテッド検証結果をふまえて、達成基準を満たすためにはその実装方法をどのように用いるべきかを解説する。</li>
</ul>

<h3>留意した点</h3>

<p>また、解説を作成する際に留意したのは次の2点である。</p>
<ul>
<li>積極的にその実装方法を用いないほうがよい理由（実装することによるユーザーへの悪影響）があるかどうか</li>
<li>より多くのユーザーがコンテンツを利用できるようになる別の実装方法があるかどうか</li>
</ul>

<h3>等級Aの解説</h3>

<p>解説を作成するにあたっては、問い合わせの多い達成基準から優先的に議論しており、ワーキンググループでの検討が終わり次第、順次公開していく予定である。</p>
<ul>
<xsl:for-each select="SuccessCriteria/SuccessCriteriaGroup[@level='A']/item">
<xsl:sort select="id" order="ascending" />
<xsl:apply-templates select="." />
</xsl:for-each>
</ul>

<h3>等級AAの解説</h3>

<p>等級AAの達成基準については、等級Aの解説作成が終わり次第、検討を始める予定である。</p>
<ul>
<xsl:for-each select="SuccessCriteria/SuccessCriteriaGroup[@level='AA']/item">
<xsl:sort select="id" order="ascending" />
<xsl:apply-templates select="." />
</xsl:for-each>
</ul>

<h2>6. 今後の予定</h2>

<p>ウェブアクセシビリティ基盤委員会（WAIC）実装ワーキンググループ（WG2）では、この「アクセシビリティ・サポーテッド（AS）情報」を今後さらに拡充していく予定である。</p>
<p>具体的には、「アクセシビリティ・サポーテッド検証結果」をもとに、達成基準ごとにどの実装方法がアクセシビリティ・サポーテッドであるかどうかを判断しやすくするための解説を作成し、この文書の「5. 達成基準ごとの解説」に順次追加していくことを考えている。</p>
<p>なお、ウェブコンテンツの想定するターゲットユーザー層、ブラウザや支援技術のバージョンアップ、新製品の登場などにより、考慮すべきユーザーの閲覧環境は変化するため、検証結果が全て「○」となっている実装方法も含めて、随時見直していく予定である。</p>

</body></html>
</xsl:template>

<xsl:template match="item">
<li>
<xsl:if test="ファイル有無='True'"><a><xsl:attribute name="href"><xsl:value-of select="id"/>.html</xsl:attribute><xsl:value-of select="id"/> <xsl:value-of select="name"/></a></xsl:if>
<xsl:if test="ファイル有無='False'"><xsl:value-of select="id"/> <xsl:value-of select="name"/></xsl:if>
</li>
</xsl:template>

</xsl:stylesheet>
