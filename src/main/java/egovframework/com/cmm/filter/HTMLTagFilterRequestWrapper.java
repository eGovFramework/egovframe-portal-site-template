/*
 * Copyright 2008-2009 MOPAS(Ministry of Public Administration and Security).
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package egovframework.com.cmm.filter;

import java.util.Map;

import org.springframework.util.ObjectUtils;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletRequestWrapper;

public class HTMLTagFilterRequestWrapper extends HttpServletRequestWrapper {

	// Tag 화이트 리스트 ( 허용할 태그 등록 )
	static private String[] whiteListTag = { "<p>","</p>","<br />" };

	public HTMLTagFilterRequestWrapper(HttpServletRequest request) {
		super(request);
	}

	public String[] getParameterValues(String parameter) {
		String[] values = super.getParameterValues(parameter);

		if (ObjectUtils.isEmpty(values)) {
			return null;			
		}

		for (int i = 0; i < values.length; i++) {
			if (values[i] != null) {
				values[i] = getSafeParamData(values[i]);
			} else {
				values[i] = null;
			}
		}

		return values;
	}

	public String getParameter(String parameter) {
		String value = super.getParameter(parameter);

		if (ObjectUtils.isEmpty(value)) {
			return null;			
		}

		value = getSafeParamData(value);

		return value;
	}

	/**
	 * Map으로 바인딩된 경우를 처리한다.
	 *
	 * @return  Map - String Type Key / String배열타입 값
	 */
	public Map<String, String[]> getParameterMap() {
    	Map<String, String[]> valueMap = super.getParameterMap();

    	String[] values;
    	for( String key : valueMap.keySet() ){
    		values = valueMap.get(key);

    		for (int i = 0; i < values.length; i++) {
    			if (values[i] != null) {				
    				values[i] = getSafeParamData(values[i]);
    			} else {
    				values[i] = null;
    			}
    		}
        }

    	return valueMap;
    }

	private String getSafeParamData(String value) {
		StringBuffer strBuff = new StringBuffer();

		for (int i = 0; i < value.length(); i++) {
			char c = value.charAt(i);
			switch (c) {
			case '<':
				if ( checkNextWhiteListTag(i, value) == false )
					strBuff.append("&lt;");
				else 
					strBuff.append(c);
				break;
			case '>':
				if ( checkPrevWhiteListTag(i, value) == false )
					strBuff.append("&gt;");
				else 
					strBuff.append(c);
				break;
			//case '&':
			//	strBuff.append("&amp;");
			//	break;
			case '"':
				strBuff.append("&quot;");
				break;
			case '\'':
				strBuff.append("&apos;");
				break;
			case '(':
				strBuff.append("&#40;");
				break;
			case ')':
				strBuff.append("&#41;");
				break;
			//case '.':
			//	strBuff.append("&#46;");
			//	break;
			default:
				strBuff.append(c);
				break;
			}
		}

		value = strBuff.toString();
		return value;
	}

	private boolean checkNextWhiteListTag(int index, String data) {
		String extractData = "";

		int endIndex = 0;
		for(String whiteListData: whiteListTag) {
			endIndex = index+whiteListData.length();

			if ( data.length() > endIndex ) {
		    	extractData = data.substring(index, endIndex);
		    } else { 
		    	extractData = "";
		    }

		    if ( whiteListData.equals(extractData) ) return true; // whiteList 대상으로 판정
		}

		return false;
	}

	private boolean checkPrevWhiteListTag(int index, String data) {
		String extractData = "";
		int beginIndex = 0;
		int endIndex = 0;

		for (String whiteListData: whiteListTag) {
			beginIndex = index-whiteListData.length()+1;
			endIndex = index+1;

			if (beginIndex >= 0) {
		    	extractData = data.substring(beginIndex, endIndex);
			} else {
		    	extractData = "";
			}

			if (whiteListData.equals(extractData)) return true; // whiteList 대상으로 판정
		}

		return false;
	}

}
