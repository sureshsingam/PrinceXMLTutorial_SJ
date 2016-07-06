<?xml version="1.0" encoding="UTF-8"?>
<xsl:transform
    version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <!-- SECTION 3 -->
  <xsl:template match="SECTION_LIST/SECTION_LIST_ITEM/NTC_SECTION_NOTICE_GROUP[SECTION_NUMBER='III' ] " >
    <div class="section3">
      <xsl:if test="$language = 'nat'">
        <h1>SEÇÃO III – <xsl:value-of select="NAME_NATIONAL" /></h1>
      </xsl:if>
      <xsl:if test="$language = 'eng'">
        <h1>SECTION III – <xsl:value-of select="NAME" /></h1>
      </xsl:if>

      <!-- list of affected charts -->
      <table id="affectedCharts">
	  <thead>
      <tr>
        <th id="acChartNumberWidth" rowspan="2" > <!-- style="width: 45%;" -->
          <xsl:if test="$language = 'nat'">
            Carta Nº 
          </xsl:if>
          <xsl:if test="$language = 'eng'">
            Chart Nº 
          </xsl:if>
        </th>
        <th colspan="3">
          <xsl:if test="$language = 'nat'">
            DESIGNAÇÃO E NÚMERO DOS AVISOS
          </xsl:if>
          <xsl:if test="$language = 'eng'">
            TYPE AND NOTICE NUMBER
          </xsl:if>
        </th>
      </tr>
      <tr>
          <xsl:if test="$language = 'nat'">
            <th>Temporários</th>
            <th>Preliminares</th>
            <th>Permanentes</th>
          </xsl:if>
          <xsl:if test="$language = 'eng'">
            <th>Temporary</th>
            <th>Preliminary</th>
            <th>Permanent</th>
          </xsl:if>
      </tr>
	  </thead>

        <xsl:call-template name="AffectedCharts"  />
      </table>
      <xsl:if test="$language = 'nat' ">
        <p style="text-indent: 4em;">Apresentam-se, a seguir, os Avisos Temporários (T) e Preliminares (P) em vigor e os Avisos Permanentes da quinzena a que se refere este Folheto.</p>
      </xsl:if>
      <xsl:if test="$language = 'eng' ">
        <p style="text-indent: 4em;">The following refers to Temporary (T) and Preliminary (P) notices in force, as well as permanent notices in the forthnight.</p>
      </xsl:if>
      <xsl:apply-templates select="SECTION_LIST/SECTION_LIST_ITEM/NTC_SECTION_NOTICE_GROUP" mode="chartnotice" />
    </div>
  </xsl:template>

  <xsl:template match="SECTION_LIST/SECTION_LIST_ITEM/NTC_SECTION_NOTICE_GROUP" mode="chartnotice">
    
    <h2 class="header_2">  
	    <xsl:if test="$language = 'nat'">
	      <xsl:value-of select="NAME_NATIONAL" />
	    </xsl:if>
	    <xsl:if test="$language = 'eng'">
	      <xsl:value-of select="NAME" />
	    </xsl:if>
    </h2>

    <xsl:apply-templates select="SECTION_LIST/SECTION_LIST_ITEM/NTC_ST_SECTION_CHART" mode="chartnotice" />
    
  </xsl:template>

  <xsl:template match="SECTION_LIST/SECTION_LIST_ITEM/NTC_ST_SECTION_CHART" mode="chartnotice">
    <xsl:if test="$language = 'nat'">
      <h3><xsl:value-of select="NAME_NATIONAL" /></h3>
      <xsl:if test="count(.//NTC_ST_TORP) = 0 and count(.//NTC_ST_CHART) = 0">
        <xsl:text>Nenhuma.</xsl:text>
      </xsl:if>

    </xsl:if>
    <xsl:if test="$language = 'eng'">
      <h3><xsl:value-of select="NAME" /></h3>
      <xsl:if test="count(.//NTC_ST_TORP) = 0 and count(.//NTC_ST_CHART) = 0">
        <xsl:text>Nil.</xsl:text>
      </xsl:if>

    </xsl:if>
    <xsl:apply-templates select="SECTION_CONTENT_LIST/SECTION_CONTENT_LIST_ITEM/NTC_ST_TORP | SECTION_CONTENT_LIST/SECTION_CONTENT_LIST_ITEM/NTC_ST_CHART" mode="chartnotice" />
  </xsl:template>

  <xsl:template match="NTC_ST_TORP | NTC_ST_CHART" mode="chartnotice" >

    <xsl:if test="$language = 'nat' ">
      <!-- Chart Notice headers -->
      <xsl:if test="normalize-space(PUBLISH_NUMBER) != '' ">
        <h3><xsl:copy-of select="concat('*', PUBLISH_NUMBER, '&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;'
        , REGION_NAT)" />
        <xsl:if test="normalize-space(SUBREGION_NAT) != '' " >
          <xsl:value-of select="concat(' - ', SUBREGION_NAT)" />
        </xsl:if>
        <xsl:if test="normalize-space(VICINITY_NAT) != '' "><xsl:value-of select="concat(' -     ', VICINITY_NAT)" /></xsl:if>
        </h3>
      </xsl:if>
      <p style='text-indent: 4em;'><xsl:value-of select="DESCRIPTION_NAT" /></p>
      <xsl:if test="normalize-space(SOURCE) != '' " >
        <p style="font-size: 6pt;"><strong>Fonte:</strong><xsl:value-of select="SOURCE"/></p>
      </xsl:if>
      <xsl:if test="normalize-space(REFERENCE_NAT) != '' " >
        <p style="font-size: 6pt;"><strong>Referência: </strong><xsl:value-of select="REFERENCE_NAT" /></p>
      </xsl:if>
      <xsl:if test="normalize-space(SELF_CANCEL_DATE) != ''" >
        <p style="font-size: 6pt;"><strong>Válido até:</strong><xsl:value-of select="SELF_CANCEL_DATE" /></p>
      </xsl:if>
    </xsl:if>

    <xsl:if test="$language = 'eng' ">
      <!-- Chart Notice headers -->
      <xsl:if test="normalize-space(PUBLISH_NUMBER) != '' ">
        <h3><xsl:copy-of select="concat('*', PUBLISH_NUMBER, '&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;'
        , REGION)" />
        <xsl:if test="normalize-space(SUBREGION) != '' " >
          <xsl:value-of select="concat(' - ', SUBREGION)" />
        </xsl:if>
        <xsl:if test="normalize-space(VICINITY) != '' "><xsl:value-of select="concat(' -     ', VICINITY)" /></xsl:if>
        </h3>
      </xsl:if>
      <p style='text-indent: 4em;'><xsl:value-of select="DESCRIPTION" /></p>
      <xsl:if test="normalize-space(SOURCE) != '' " >
        <p style="font-size: 6pt;"><strong>Source:</strong><xsl:value-of select="SOURCE"/></p>
      </xsl:if>
      <xsl:if test="normalize-space(REFERENCE) != '' " >
        <p style="font-size: 6pt;"><strong>References: </strong><xsl:value-of select="REFERENCE" /></p>
      </xsl:if>
      <xsl:if test="normalize-space(SELF_CANCEL_DATE) != ''" >
        <p style="font-size: 6pt;"><strong>Valid Until:</strong><xsl:value-of select="SELF_CANCEL_DATE" /></p>
      </xsl:if>
    </xsl:if>

    <!-- Check for cancelled notices -->
    <xsl:if test="count(CANCELLED_NOTICE_LIST/CANCELLED_NOTICE_LIST_ITEM/*/CANCELLED_PUB_ID[. != '' ]) > 0 or count(CANCELLED_NOTICE_LIST//PUBLISH_NUMBER) > 0" >
      <xsl:if test="$language = 'nat' ">
          <p>   
              <xsl:if test="./CANCELLED_NOTICE_LIST//TERM = 'Temporary' ">
              <xsl:text>Este Aviso Cancela o Aviso Temporário </xsl:text> 
            </xsl:if>
            <xsl:if test="./CANCELLED_NOTICE_LIST//TERM = Preliminary">
              <xsl:text>Este Aviso Cancela o Aviso Preliminares </xsl:text> 
            </xsl:if>
            <xsl:if test="./CANCELLED_NOTICE_LIST//TERM = 'Permanent' or count(.//NTC_EXTERNAL) > 0">
              <xsl:text>Este Aviso Cancela o Aviso Permanentes</xsl:text> 
            </xsl:if>
 
          
          <xsl:for-each select="CANCELLED_NOTICE_LIST/CANCELLED_NOTICE_LIST_ITEM[./*/CANCELLED_PUB_ID != '' or .//PUBLISH_NUMBER != '' ]" >
            <xsl:if test="position() = last()">
              <xsl:text> e </xsl:text>
            </xsl:if>
            <xsl:if test="./*/CANCELLED_PUB_ID != '' ">
                <xsl:value-of select="./*/CANCELLED_PUB_ID" />
            </xsl:if>
            <xsl:if test=".//PUBLISH_NUMBER != '' ">
                <xsl:value-of select=".//PUBLISH_NUMBER " />
            </xsl:if>
            <xsl:if test="position() != last()">
              <xsl:text>, </xsl:text>
            </xsl:if>
          </xsl:for-each>
        </p>
      </xsl:if>

      <xsl:if test="$language = 'eng' ">
          <p>
              <xsl:if test="./CANCELLED_NOTICE_LIST//TERM = 'Temporary' ">
              <xsl:text>This notice cancels Temporary Notice n° </xsl:text> 
            </xsl:if>
            <xsl:if test="./CANCELLED_NOTICE_LIST//TERM = Preliminary">
              <xsl:text>This notice cancels Preliminary Notice n° </xsl:text> 
            </xsl:if>
            <xsl:if test="./CANCELLED_NOTICE_LIST//TERM = 'Permanent' or count(.//NTC_EXTERNAL) > 0">
              <xsl:text>This notice cancels Permanent Notice n° </xsl:text> 
            </xsl:if>

           
            <xsl:for-each select="CANCELLED_NOTICE_LIST/CANCELLED_NOTICE_LIST_ITEM[./*/CANCELLED_PUB_ID != '' or .//PUBLISH_NUMBER != '' ]" >
              <xsl:if test="position() = last()">
                <xsl:text> &#x26; </xsl:text>
              </xsl:if>
              <xsl:if test="./*/CANCELLED_PUB_ID != '' ">
                  <xsl:value-of select="./*/CANCELLED_PUB_ID" />
              </xsl:if>
              <xml:if>
                  <xsl:value-of select=".//PUBLISH_NUMBER" />
              </xml:if>
              <xsl:if test="position() != last()">
                <xsl:text>, </xsl:text>
              </xsl:if>
            </xsl:for-each>
          </p>
      </xsl:if>

    </xsl:if>

    <!-- Output chart notice instructions -->
    <table class="chartinstruct">
        <xsl:apply-templates select="INSTRUCTION_LIST/INSTRUCTION_LIST_ITEM/NTC_ST_CHARTINSTRUCT | INSTRUCTION_LIST/INSTRUCTION_LIST_ITEM/NTC_ST_TABLE_INSTRUCTION" mode="chartnotice" />
    </table>
  </xsl:template>

<xsl:template match="NTC_ST_TABLE_INSTRUCTION" mode="chartnotice" >
  <tr>
    <td colspan="10">
      <table class="GenericInstructionTable" > <!-- style="width: 100%;" -->
        <xsl:for-each select="GENERIC_TABLE">
          <xsl:for-each select="TABLE_HEADER/ROW" >
            <tr>
              <xsl:for-each select="COLUMN">
                <th>
                  <xsl:value-of select="." />
                </th>
              </xsl:for-each>
            </tr>
          </xsl:for-each>
          <xsl:for-each select="TABLE_BODY/ROW" >
            <tr>
              <xsl:for-each select="COLUMN">
                <td>
                  <xsl:value-of select="." />
                </td>
              </xsl:for-each>
            </tr>
          </xsl:for-each>

        </xsl:for-each>
      </table>
    </td>
  </tr>
</xsl:template>

  <xsl:template match="NTC_ST_CHARTINSTRUCT" mode="chartnotice">
      <!-- Chart List -->
      <tr>
        <td colspan="10">
          <xsl:for-each select=".//ST_CHART_LIST/ST_CHART">
            
            <strong>
              <xsl:if test="$language = 'nat' ">
                <xsl:if test="last() = 1">Carta n°&#160;</xsl:if>
                <xsl:if test="last() != 1">Cartas n°s&#160;</xsl:if>            
              </xsl:if>
              <xsl:if test="$language = 'eng' ">
                <xsl:if test="last() = 1">Chart n°&#160;</xsl:if>
                <xsl:if test="last() != 1">Chart  n°s&#160;</xsl:if>            
              </xsl:if>

              <xsl:value-of select="CHART_NUM" />
              <xsl:if test="CHART_INT_NUM">
                <xsl:value-of select="concat('(', CHART_INT_NUM, ') ')" />
              </xsl:if>
            </strong>
            <xsl:if test="normalize-space(HORIZ_DATUM) != '' " >
              <xsl:value-of select="concat('&#160;Datum: ', HORIZ_DATUM)" />
            </xsl:if>
            <xsl:if test="LAST_CORRECTION" >
              <xsl:if test="$language = 'nat' " >
                <xsl:value-of select="concat(' (Última correção ', LAST_CORRECTION, ')')" />
              </xsl:if>
              <xsl:if test="$language = 'eng' " >
                <xsl:value-of select="concat(' (Last Correction ', LAST_CORRECTION, ')')" />
              </xsl:if>
            </xsl:if>
            <xsl:if test="position() != last()" >
              <xsl:text> - </xsl:text>
            </xsl:if>
          </xsl:for-each>
        </td>
      </tr>

    <!-- Actions -->
      <xsl:variable name="action">
        <xsl:value-of select="ACTION" />
      </xsl:variable>
      <xsl:for-each select="ENHANCED_ATT_DESC_POSITION_LIST/ATT_DESC_POSTN_LIST_COMPLEX/DESCRIPTION_POSTN_LIST/DESC_POS_COMPLEX" >
        <tr>
          <td style="padding-right: 1em;">
            <xsl:if test="position() = '1' ">
              <xsl:value-of select="$action"/>
            </xsl:if>
          </td>
          <xsl:if test="../../ATTACHMENT/FILENAME">
            <td><img src="{concat($currentPath, '/', ../../ATTACHMENT/FILENAME)}" /></td>
          </xsl:if>
          <td>
            <xsl:if test="$language = 'nat' ">
              <xsl:copy-of select="DESCRIPTION_NAT" />
            </xsl:if>
            <xsl:if test="$language = 'eng' ">
              <xsl:copy-of select="DESCRIPTION_ENG" />
            </xsl:if>
          </td>
          <td style="text-align: right;">
            <table>
            <xsl:for-each select="ST_POSITION_LIST/ST_POSITION" >
              <tr>
                <xsl:if test="count(../..//LABEL) > 0" >
                  <td style="white-space: nowrap; padding-right: 1em;">
                    <xsl:if test="normalize-space(LABEL) != '' " >
                    <xsl:value-of select="LABEL" />
                    </xsl:if>
                  </td>
                </xsl:if>
                <td style="white-space: nowrap;">
                  <xsl:value-of select="concat(LATITUDE, ' ', LONGITUDE)" /><br />
                </td>
                <xsl:if test="normalize-space(POS_DESCRIPTION_NAT) != '' or normalize-space(POS_DESCRIPTION) != '' ">
                <td style="white-space: nowrap;">
                  <xsl:if test="$language = 'nat' ">
                    <xsl:value-of select="normalize-space(POS_DESCRIPTION_NAT)" />
                  </xsl:if>
                  <xsl:if test="$language = 'eng' ">
                    <xsl:value-of select="normalize-space(POS_DESCRIPTION)" />
                  </xsl:if>
                </td>
                </xsl:if>
              </tr>
            </xsl:for-each>
            </table>
          </td>
        </tr>
      </xsl:for-each>
      <xsl:if test="normalize-space(ADD_DESCRIPTION_NAT) != '' or normalize-space(ADD_DESCRIPTION_ENG)">
        <tr>
		  <xsl:if test="$language = 'eng' " >
			<td colspan="10"><xsl:value-of select="ADD_DESCRIPTION_ENG" /></td>
		  </xsl:if>
		  <xsl:if test="$language = 'nat' " >
			<td colspan="10"><xsl:value-of select="ADD_DESCRIPTION_NAT" /></td>
		  </xsl:if>		
        </tr>
      </xsl:if>
  </xsl:template>

  <xsl:template name="AffectedCharts" >

    <!-- build a list of chart lists for all the notices -->
    <xsl:variable name="charts" >
      <xsl:for-each select=".//CHART_NUM" >
        <xsl:sort select="." />
        <xsl:value-of select="." />
        <xsl:if test="position() != last()">
          <xsl:text>|</xsl:text>
        </xsl:if>
      </xsl:for-each>
    </xsl:variable>

    <!-- make this list of chart lists unique -->
    <xsl:variable name="uniqueCharts">
      <xsl:call-template name="Uniquetokens"  >
        <xsl:with-param name="list" select="$charts" />
        <xsl:with-param name="delimiter" select="'|'" />
      <xsl:with-param name="newDelimiter" select="'|'"/>
      <xsl:with-param name="name"/>
      <xsl:with-param name="terminator"/>
      </xsl:call-template>
    </xsl:variable>

    <xsl:call-template name="AffectedChartRow">
      <xsl:with-param name="chartList" select="$uniqueCharts" />
    </xsl:call-template>

  </xsl:template>

<xsl:template name="GetChartList"  >
    <xsl:variable name="charts">
        <xsl:for-each select=".//CHART_NUM" >
          <xsl:sort select="." />
          <xsl:value-of select="." />
          <xsl:text>,</xsl:text>
      </xsl:for-each>
    </xsl:variable>

    <xsl:variable name="uniqueCharts">
      <xsl:call-template name="Uniquetokens"  >
        <xsl:with-param name="list" select="$charts" />
        <xsl:with-param name="delimiter" select="','" />
      <xsl:with-param name="newDelimiter" select="','"/>
      <xsl:with-param name="name"/>
      <xsl:with-param name="terminator"/>
      </xsl:call-template>
    </xsl:variable>

    <xsl:value-of select="$uniqueCharts" />
</xsl:template>

    <xsl:template name="AffectedChartRow">
      <xsl:param name="chartList"/>

      <!-- get the first chart list -->
      <xsl:variable name="firstChart" >
        <xsl:if test="normalize-space(substring-before($chartList, '|')) != '' ">
          <xsl:value-of select="normalize-space(substring-before($chartList, '|'))" />
        </xsl:if>
        <xsl:if test="normalize-space(substring-before($chartList, '|')) = '' ">
          <xsl:value-of select="normalize-space($chartList)" />
        </xsl:if>
      </xsl:variable>
      <!-- get the additional charts -->
      <xsl:variable name="additionalChartLists">
          <xsl:value-of select="normalize-space(substring-after($chartList, '|'))" />
      </xsl:variable>

      <!-- for each chart or torp notice, get its unique chart list, and output row if its chart list = current chart list -->
      <xsl:if test="$firstChart != '' ">
          <tbody>
          <tr>
            <td id="acChartNumberWidth" ><xsl:value-of select="$firstChart" /></td>   <!-- style="width: 45%" -->
            <!-- Temporary -->
            <td>
              <xsl:variable name="noticesToPrint">
                <xsl:for-each select="//NTC_ST_TORP | //NTC_ST_CHART" >
                  <xsl:variable name="noticeChartList">
                    <xsl:call-template name="GetChartList" />
                  </xsl:variable>

                  <xsl:if test="contains($noticeChartList,$firstChart) and TERM = 'Temporary' " >
                    <xsl:text>,</xsl:text>
                    <xsl:value-of select="PUBLISH_NUMBER" />                    
                  </xsl:if>
                </xsl:for-each>
              </xsl:variable>
              <xsl:value-of select="substring-after($noticesToPrint, ',')" /> <!-- substring is needed to strip off leading comma -->
            </td>

            <!-- Preliminary -->
            <td>
              <xsl:variable name="noticesToPrint">
                <xsl:for-each select="//NTC_ST_TORP | //NTC_ST_CHART" >
                  <xsl:variable name="noticeChartList">
                    <xsl:call-template name="GetChartList" />
                  </xsl:variable>

                  <xsl:if test="contains($noticeChartList, $firstChart) and TERM = 'Preliminary' " >
                    <xsl:text>,</xsl:text>
                    <xsl:value-of select="PUBLISH_NUMBER" />                    
                  </xsl:if>
                </xsl:for-each>
              </xsl:variable>
              <xsl:value-of select="substring-after($noticesToPrint, ',')" /> <!-- substring is needed to strip off leading comma -->
            </td>

            <!-- Permanent -->
            <td>
              <xsl:variable name="noticesToPrint">
                <xsl:for-each select="//NTC_ST_TORP | //NTC_ST_CHART" >
                  <xsl:variable name="noticeChartList">
                    <xsl:call-template name="GetChartList" />
                  </xsl:variable>

                  <xsl:if test="contains($noticeChartList, $firstChart) and (TERM = 'Permanent' or name() = 'NTC_ST_CHART') " >
                    <xsl:text>,</xsl:text>
                    <xsl:value-of select="PUBLISH_NUMBER" />                    
                  </xsl:if>
                </xsl:for-each>
              </xsl:variable>
              <xsl:value-of select="substring-after($noticesToPrint, ',')" /> <!-- substring is needed to strip off leading comma -->
            </td>
          </tr>
		  </tbody>
      </xsl:if>

      <!-- recurse if there are additional chart lists -->
      <xsl:if test="$additionalChartLists != '' ">
        <xsl:call-template name="AffectedChartRow" >
          <xsl:with-param name="chartList" select="$additionalChartLists" />
        </xsl:call-template>
      </xsl:if>
      
    </xsl:template>

  <!--xsl:template name="IterateCharts">
      <xsl:param name="charts" />

      <xsl:variable name="firstChart">
        <xsl:if test="normalize-space(substring-before($charts, ',')) != ''">
          <xsl:value-of select="normalize-space(substring-before($charts, ','))" />
        </xsl:if>
        <xsl:if test="normalize-space(substring-before($charts, ',')) = ''">
          <xsl:value-of select="normalize-space($charts)" />
        </xsl:if>
      </xsl:variable>
      <xsl:variable name="additionalCharts" select="substring-after($charts, ',')" />
      <xsl:variable name="type">
        <xsl:value-of select="test" />
      </xsl:variable>
      <xsl:variable name="label">

      </xsl:variable>
      <tr>
        <td style="width: 45%'"><xsl:value-of select="$firstChart" /></td>
        <td> </td>
        <td> </td>
        <td> </td>
      </tr>
      <xsl:if test="normalize-space($additionalCharts) != '' ">
        <xsl:call-template name="IterateCharts">
          <xsl:with-param name="charts" select="$additionalCharts" />
        </xsl:call-template>
      </xsl:if>
  </xsl:template-->

</xsl:transform>
