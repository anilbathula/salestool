/* ============================================================
	Copyright (c) 2011 LogicLine EDV-SystemService GmbH
	All rights reserved.
	
	Redistribution in source and binary forms, with or without
	modification, are not permitted.
	
	THIS SOFTWARE IS PROVIDED BY THE AUTHOR "AS IS" AND ANY EXPRESS OR
	IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
	OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
	IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT, 
	INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
	NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
	DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
	THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
	(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
	THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 * ============================================================ 
 */
*[id$="wall-header"], *[id$="wall-footer"]
{
	background:#FFF;
	left:0;
	width:100%;
	z-index:2;
	position:fixed;
}

*[id$="wall-header"]
{
	border-bottom:1px solid #000;
	height:55px;
	top:0;
}

*[id$="wall-footer"]
{
	border-top:1px solid #000;
	height:30px;
	bottom:0; 
	vertical-align:center;
}

.aggregate
{
	color: #444;
}

table[id$="wall-header"] input[type="button"],table[id$="wall-header"] input[type="submit"]
{
	font-size:1.2em;
	height:30px;
	margin:0 10px;
	padding:0 10px;
}

#wallform
{
	border-width:0;
}

.collapse-head
{
	margin:10px;
	width:100%;
}

.wall
{
	margin-left:auto;
	margin-right:auto;
	margin-top:65px;
	position:relative;
	text-align:center;
	white-space:nowrap;
	width:100%;
}

.column
{
	background-color:#aaa;
	border:1px dashed #AAA;
	display:inline-block;
	margin:0 10px;
	max-width:540px;
	min-height:550px;
	min-width:280px;
	padding:0;
	vertical-align:top;
}

.column-header
{
	border-bottom:1px solid #000;
	width:100%;
	height: 30px;
	overflow: hidden;
}

.column-header > div
{
	float:left;
	padding-left:3%;
	width:44%;
}

.column h2
{
	display:block;
	font-size:1.3em;
	line-height:2em;
	text-align:center;
}

.column-body
{
	float:left;
	height:100%;
	list-style-type:none;
	margin:0;
	padding:0;
	width:100%;
}

.card
{
	-moz-box-shadow:2px 2px 2px #666;
	-webkit-box-shadow:2px 2px 2px #666;
	background-color:#fff;
	box-shadow:2px 2px 2px #666;
	float:left;
	margin:13px 10px;
	padding:4px;
	position:relative;
	text-align:left;
	width:240px;
}

column-body > li
{
	background-color:gray;
}

div.onecolumn
{
	max-width:270px;
}

.errorMsg
{
	background-color:#D55;
	color:#FFF;
	font-style:italic;
	max-width:220px;
	padding:4px;
	position:absolute !important;
	text-align:left !important;
	top:176px;
	white-space:normal !important;
	z-index:1;
}

.collapsed .errorMsg
{
	top:92px;
}
.handle
{
	cursor: pointer;
}
.separator
{
   	padding-right:20px;
}
.New { background-color: #FF0; }