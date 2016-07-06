<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet
  version="1.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:exslt="http://exslt.org/common"
  xmlns:msxsl="urn:schemas-microsoft-com:xslt"
  xmlns:user="http://caris.com/msxsl"
  exclude-result-prefixes="exslt msxsl">

<xsl:import href="ntm_section3.xsl" />


<xsl:variable name="language" select="'eng'" />
<!--xsl:variable name="currentPath" select="user:getCurrentPath()" /-->
<xsl:variable name="currentPath" select="'file://D:/Publication_Module/images'" />

  <xsl:output method="html" encoding="UTF-8"/>

  <!-- Match the root of the XML and set up the framing for the output html document -->
  <xsl:template match="/">
    <html xmlns="http://www.w3.org/1999/xhtml">
      <meta http-equiv="Content-type" content="text/html; charset=utf-8" />
      
      <head>
		<link rel="stylesheet" type="text/css" href="print.css" media="print"/> 
		<link rel="stylesheet" type="text/css" href="screen.css" media="screen"/> 

      </head>

      <body>
        <div class="mainbody">
	        <div>
	          <xsl:apply-templates select="//SECTION_LIST/SECTION_LIST_ITEM/NTC_SECTION_NOTICE_GROUP[SECTION_NUMBER='III' ]" />
	        </div>

        </div>
      </body>

    </html>
  </xsl:template>

  <!-- Template to return unique token values from a sorted delimited list -->
  <xsl:template name="Uniquetokens">
    <xsl:param name="list" />  <!-- A delimited list in a string that is already sorted-->
    <xsl:param name="delimiter" /> <!-- The delimiter eg ',' -->
    <xsl:param name="newDelimiter" /> <!-- The delimiter to use on output ',' -->
    <xsl:param name="name" /> <!-- optional, element name to output unique values into -->
    <xsl:param name="terminator" /> <!-- what to put at end of list -->

    <xsl:if test="normalize-space($list) != '' " >
      
      <!-- Make sure the string is cleaned up.  Extra white space removed and at least a delimiter on the end -->
      <xsl:variable name="newlist">
        <xsl:choose>
          <xsl:when test="contains($list, $delimiter)"><xsl:value-of select="normalize-space($list)" /></xsl:when>
          <xsl:otherwise><xsl:value-of select="concat(normalize-space($list), $delimiter)"/></xsl:otherwise>
        </xsl:choose>
      </xsl:variable>
      
      <!--Parse the first string up to the delimiter-->
      <xsl:variable name="first" select="normalize-space(substring-before($newlist, $delimiter))" />
      <!--Parse the remainder after the delimiter-->
      <xsl:variable name="remaining" select="normalize-space(substring-after($newlist, $delimiter))" />
      
      <xsl:choose>
        <!--if first is same as next, skip and recurse with the rest-->
        <xsl:when test="$remaining and(starts-with($remaining,$first))">
          <xsl:call-template name="Uniquetokens">
            <xsl:with-param name="list" select="$remaining" />
            <xsl:with-param name="delimiter" select="$delimiter" />
            <xsl:with-param name="newDelimiter" select="$newDelimiter" />
            <xsl:with-param name="name" select="$name" />
            <xsl:with-param name="terminator" select="$terminator" />
          </xsl:call-template>
        </xsl:when>
        <xsl:when test="$remaining != '' ">
          
          <xsl:choose>
            <xsl:when test="$name">
              <xsl:element name="{$name}">    
                <xsl:value-of select="$first" />
              </xsl:element>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="$first" />
              <xsl:value-of select="$newDelimiter" />
            </xsl:otherwise>
          </xsl:choose>
          
          <!-- then recursively call this template -->
          <xsl:call-template name="Uniquetokens">
            <xsl:with-param name="list" select="$remaining" />
            <xsl:with-param name="delimiter" select="$delimiter" />
            <xsl:with-param name="newDelimiter" select="$newDelimiter" />
            <xsl:with-param name="name" select="$name" />
            <xsl:with-param name="terminator" select="$terminator" />
          </xsl:call-template>
        </xsl:when>
        <xsl:otherwise>
          <!--otherwise This is the last entry output with terminator -->
          <xsl:choose>
            <xsl:when test="$name">
              <xsl:element name="{$name}">    
                <xsl:value-of select="$first" />
              </xsl:element>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="$first" />
              <xsl:value-of select="$terminator" />
            </xsl:otherwise>
          </xsl:choose>
        </xsl:otherwise>
      </xsl:choose>
      
    </xsl:if>
  </xsl:template>

  <!--msxsl:script language="JScript" implements-prefix="user">
    <![CDATA[
             var fso = new ActiveXObject("Scripting.FileSystemObject");

function getCurrentPath(){
return fso.GetFolder(".").Path
}
    ]]>
  </msxsl:script-->

</xsl:stylesheet>
