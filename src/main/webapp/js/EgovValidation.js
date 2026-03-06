/**
 * eGovFrame Common Validation JavaScript Library
 * Spring Modules Validation을 대체하는 클라이언트사이드 검증 라이브러리
 */

const EgovValidation = {
    
    // 에러 메시지 설정
    messages: {
        required: '{0}은(는) 필수입력 항목입니다.',
        maxlength: '{0}은(는) {1}자를 초과할 수 없습니다.',
        minlength: '{0}은(는) {1}자 이상이어야 합니다.',
        integer: '{0}은(는) 숫자여야 합니다.',
        email: '{0}은(는) 올바른 이메일 형식이 아닙니다.',
        password1: '패스워드는 8~20자 이내여야 합니다.',
        password2: '패스워드에 특수문자를 사용할 수 없습니다.',
        password3: '연속된 문자나 순차적인 문자 4개 이상 사용할 수 없습니다.',
        password4: '반복문자나 숫자 연속 4개 이상 사용할 수 없습니다.',
        pwdCheckComb3: '영문자, 숫자, 특수문자의 최소 3가지 조합이어야 합니다.',
        pwdCheckComb4: '영대문자, 영소문자, 숫자, 특수문자의 최소 4가지 조합이어야 합니다.',
        pwdCheckSeries: '연속된 3개 이상의 문자나 숫자를 사용할 수 없습니다.',
        pwdCheckRepeat: '반복된 3개 이상의 문자나 숫자를 사용할 수 없습니다.',
        english: '{0}은(는) 영문자만 입력 가능합니다.'
    },
    
    // 기본 validation 규칙들
    rules: {
        // 필수입력 검사
        required: function(value) {
            return value !== null && value !== undefined && 
                   (typeof value === 'string' ? value.trim().length > 0 : true);
        },
        
        // 최대 길이 검사
        maxlength: function(value, max) {
            if (!value) return true;
            return value.length <= parseInt(max);
        },
        
        // 최소 길이 검사
        minlength: function(value, min) {
            if (!value) return true;
            return value.length >= parseInt(min);
        },
        
        // 숫자 검사
        integer: function(value) {
            if (!value) return true;
            return /^\d+$/.test(value);
        },
        
        // 이메일 검사
        email: function(value) {
            if (!value) return true;
            const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            return emailRegex.test(value);
        },
        
        // 영문자만 허용
        english: function(value) {
            if (!value) return true;
            return /^[a-zA-Z]+$/.test(value);
        },
        
        // 패스워드 길이 검사 (8~20자)
        password1: function(value) {
            if (!value) return true;
            return value.length >= 8 && value.length <= 20;
        },
        
        // 패스워드 특수문자 제한
        password2: function(value) {
            if (!value) return true;
            // 특수문자 체크 (ASCII 33-47, 58-64, 91-96, 123-126)
            for (let i = 0; i < value.length; i++) {
                const ch = value.charCodeAt(i);
                if ((ch >= 33 && ch <= 47) || (ch >= 58 && ch <= 64) || 
                    (ch >= 91 && ch <= 96) || (ch >= 123 && ch <= 126)) {
                    return false;
                }
            }
            return true;
        },
        
        // 연속된 문자/순차적 문자 4개 이상 금지
        password3: function(value) {
            if (!value) return true;
            let cnt = 0, cnt2 = 1, cnt3 = 1;
            let temp = "";
            
            for (let i = 0; i < value.length; i++) {
                const ch = value.charAt(i);
                if (i > 0) {
                    const prevCh = value.charAt(i-1);
                    if (ch.charCodeAt(0) - prevCh.charCodeAt(0) === 1) {
                        cnt2++;
                        if (cnt2 >= 4) return false;
                    } else {
                        cnt2 = 1;
                    }
                    
                    if (ch.charCodeAt(0) - prevCh.charCodeAt(0) === -1) {
                        cnt3++;
                        if (cnt3 >= 4) return false;
                    } else {
                        cnt3 = 1;
                    }
                }
            }
            return true;
        },
        
        // 반복문자/숫자 연속 4개 이상 금지
        password4: function(value) {
            if (!value) return true;
            for (let i = 0; i < value.length - 3; i++) {
                if (value.charAt(i) === value.charAt(i+1) && 
                    value.charAt(i) === value.charAt(i+2) && 
                    value.charAt(i) === value.charAt(i+3)) {
                    return false;
                }
            }
            return true;
        },
        
        // 3가지 조합 (영문자, 숫자, 특수문자)
        pwdCheckComb3: function(value) {
            if (!value) return true;
            let hasAlpha = /[a-zA-Z]/.test(value);
            let hasNum = /\d/.test(value);
            let hasSpecial = /[~!@#$%^&*?]/.test(value);
            
            let count = 0;
            if (hasAlpha) count++;
            if (hasNum) count++;
            if (hasSpecial) count++;
            
            return count >= 3;
        },
        
        // 4가지 조합 (영대문자, 영소문자, 숫자, 특수문자)
        pwdCheckComb4: function(value) {
            if (!value) return true;
            let hasUpper = /[A-Z]/.test(value);
            let hasLower = /[a-z]/.test(value);
            let hasNum = /\d/.test(value);
            let hasSpecial = /[~!@#$%^&*?]/.test(value);
            
            let count = 0;
            if (hasUpper) count++;
            if (hasLower) count++;
            if (hasNum) count++;
            if (hasSpecial) count++;
            
            return count >= 4;
        },
        
        // 연속된 3개 이상의 문자나 숫자 금지
        pwdCheckSeries: function(value) {
            if (!value) return true;
            for (let i = 0; i < value.length - 2; i++) {
                const ch1 = value.charCodeAt(i);
                const ch2 = value.charCodeAt(i+1);
                const ch3 = value.charCodeAt(i+2);
                
                if ((ch2 - ch1 === 1 && ch3 - ch2 === 1) || 
                    (ch1 - ch2 === 1 && ch2 - ch3 === 1)) {
                    return false;
                }
            }
            return true;
        },
        
        // 반복된 3개 이상의 문자나 숫자 금지
        pwdCheckRepeat: function(value) {
            if (!value) return true;
            for (let i = 0; i < value.length - 2; i++) {
                if (value.charAt(i) === value.charAt(i+1) && 
                    value.charAt(i) === value.charAt(i+2)) {
                    return false;
                }
            }
            return true;
        }
    },
    
    // 폼 검증 함수
    validateForm: function(formElement, validationRules) {
        const errors = [];
        let firstErrorField = null;
        
        for (const fieldName in validationRules) {
            const field = formElement.elements[fieldName];
            if (!field) continue;
            
            const fieldRules = validationRules[fieldName];
            const fieldValue = this.getFieldValue(field);
            const fieldLabel = fieldRules.label || fieldName;
            
            // 각 규칙별로 검증
            for (const ruleName in fieldRules.rules) {
                if (ruleName === 'label') continue;
                
                const ruleValue = fieldRules.rules[ruleName];
                const ruleFunction = this.rules[ruleName];
                
                if (ruleFunction) {
                    let isValid = false;
                    
                    if (ruleValue === true) {
                        // 매개변수가 없는 규칙
                        isValid = ruleFunction(fieldValue);
                    } else {
                        // 매개변수가 있는 규칙
                        isValid = ruleFunction(fieldValue, ruleValue);
                    }
                    
                    if (!isValid) {
                        const errorMsg = this.formatMessage(this.messages[ruleName], fieldLabel, ruleValue);
                        errors.push(errorMsg);
                        
                        if (!firstErrorField) {
                            firstErrorField = field;
                        }
                        break; // 첫 번째 에러만 표시
                    }
                }
            }
        }
        
        if (errors.length > 0) {
            alert(errors.join('\n'));
            if (firstErrorField) {
                firstErrorField.focus();
            }
            return false;
        }
        
        return true;
    },
    
    // 필드 값 가져오기
    getFieldValue: function(field) {
        if (!field) return '';
        
        if (field.type === 'checkbox' || field.type === 'radio') {
            if (field.length) {
                // 배열인 경우
                for (let i = 0; i < field.length; i++) {
                    if (field[i].checked) {
                        return field[i].value;
                    }
                }
                return '';
            } else {
                return field.checked ? field.value : '';
            }
        } else if (field.type === 'select-one') {
            return field.selectedIndex >= 0 ? field.options[field.selectedIndex].value : '';
        } else if (field.type === 'select-multiple') {
            const values = [];
            for (let i = 0; i < field.options.length; i++) {
                if (field.options[i].selected) {
                    values.push(field.options[i].value);
                }
            }
            return values.join(',');
        } else {
            return field.value || '';
        }
    },
    
    // 메시지 포맷팅
    formatMessage: function(template, ...args) {
        return template.replace(/{(\d+)}/g, function(match, index) {
            return args[index] !== undefined ? args[index] : match;
        });
    },
    
    // 문자열 trim 유틸리티
    trim: function(str) {
        return str ? str.replace(/^\s+|\s+$/g, '') : '';
    }
};

// 전역 함수로 노출 (기존 코드 호환성을 위해)
window.EgovValidation = EgovValidation;

// 기존 Spring Modules validation 함수들을 대체하는 래퍼 함수들

// 게시판 사용정보 관리
function validateBoardUseInf(form) {
    const rules = {
        bbsId: {
            label: '게시판명',
            rules: {
                required: true
            }
        },
        trgetId: {
            label: '대상명',
            rules: {
                required: true
            }
        }
    };
    return EgovValidation.validateForm(form, rules);
}

// 템플릿 관리
function validateTemplateInf(form) {
    const rules = {
        tmplatNm: {
            label: '템플릿명',
            rules: {
                required: true,
                maxlength: 120
            }
        },
        tmplatCours: {
            label: '템플릿경로',
            rules: {
                required: true,
                maxlength: 2000
            }
        },
        tmplatSeCode: {
            label: '템플릿구분코드',
            rules: {
                required: true
            }
        }
    };
    return EgovValidation.validateForm(form, rules);
}

// 공지사항 관리
function validateBoard(form) {
    const rules = {
        nttSj: {
            label: '제목',
            rules: {
                required: true,
                maxlength: 1200
            }
        },
        nttCn: {
            label: '내용',
            rules: {
                required: true
            }
        },
        ntceBgnde: {
            label: '공지시작일',
            rules: {
                required: true
            }
        },
        ntceEndde: {
            label: '공지종료일',
            rules: {
                required: true
            }
        },
        ntcrNm: {
            label: '작성자명',
            rules: {
                required: true
            }
        },
        password: {
            label: '비밀번호',
            rules: {
                required: true
            }
        }
    };
    return EgovValidation.validateForm(form, rules);
}

// 게시판 마스터 관리
function validateBoardMaster(form) {
    const rules = {
        bbsNm: {
            label: '게시판명',
            rules: {
                required: true,
                maxlength: 60
            }
        },
        bbsIntrcn: {
            label: '게시판소개',
            rules: {
                required: true,
                maxlength: 200
            }
        },
        bbsTyCode: {
            label: '게시판유형',
            rules: {
                required: true
            }
        },
        replyPosblAt: {
            label: '답장가능여부',
            rules: {
                required: true
            }
        },
        fileAtchPosblAt: {
            label: '파일첨부가능여부',
            rules: {
                required: true
            }
        },
        atchPosblFileNumber: {
            label: '첨부가능파일숫자',
            rules: {
                required: true,
                integer: true
            }
        },
        atchPosblFileSize: {
            label: '첨부가능파일사이즈',
            rules: {
                required: true,
                integer: true
            }
        },
        useAt: {
            label: '사용여부',
            rules: {
                required: true
            }
        }
    };
    return EgovValidation.validateForm(form, rules);
}

// 권한 관리
function validateAuthorManage(form) {
    const rules = {
        authorCode: {
            label: '권한 코드',
            rules: {
                required: true
            }
        },
        authorNm: {
            label: '권한 명',
            rules: {
                required: true
            }
        }
    };
    return EgovValidation.validateForm(form, rules);
}

// 그룹 관리
function validateGroupManage(form) {
    const rules = {
        groupNm: {
            label: '그룹 명',
            rules: {
                required: true
            }
        }
    };
    return EgovValidation.validateForm(form, rules);
}

// 롤 관리
function validateRoleManage(form) {
    const rules = {
        roleNm: {
            label: '롤 명',
            rules: {
                required: true
            }
        },
        rolePtn: {
            label: '롤 패턴',
            rules: {
                required: true
            }
        },
        roleSort: {
            label: '롤 Sort',
            rules: {
                required: true,
                integer: true
            }
        }
    };
    return EgovValidation.validateForm(form, rules);
}

// 회원 관리
function validateMberManageVO(form) {
    const rules = {
        mberId: {
            label: '일반회원아이디',
            rules: {
                required: true,
                maxlength: 20
            }
        },
        mberNm: {
            label: '일반회원이름',
            rules: {
                required: true,
                maxlength: 60
            }
        },
        passwordHint: {
            label: '비밀번호힌트',
            rules: {
                required: true
            }
        },
        passwordCnsr: {
            label: '비밀번호정답',
            rules: {
                required: true,
                maxlength: 100
            }
        },
        areaNo: {
            label: '집지역번호',
            rules: {
                maxlength: 4
            }
        },
        middleTelno: {
            label: '집중간전화번호',
            rules: {
                maxlength: 4
            }
        },
        endTelno: {
            label: '집마지막전화번호',
            rules: {
                maxlength: 4
            }
        },
        mberFxnum: {
            label: '팩스번호',
            rules: {
                maxlength: 15
            }
        },
        moblphonNo: {
            label: '핸드폰번호',
            rules: {
                maxlength: 15
            }
        }
    };
    return EgovValidation.validateForm(form, rules);
}

// 비밀번호 변경
function validatePasswordChgVO(form) {
    const rules = {
        oldPassword: {
            label: '기존비밀번호',
            rules: {
                required: true
            }
        },
        newPassword: {
            label: '새비밀번호',
            rules: {
                required: true
            }
        },
        newPassword2: {
            label: '새비밀번호확인',
            rules: {
                required: true
            }
        }
    };
    return EgovValidation.validateForm(form, rules);
}

// Q&A 관리
function validateQnaManageVO(form) {
    const rules = {
        wrterNm: {
            label: '작성자명',
            rules: {
                required: true,
                maxlength: 20
            }
        },
        writngPassword: {
            label: '작성비밀번호',
            rules: {
                required: true,
                maxlength: 20
            }
        },
        areaNo: {
            label: '지역번호',
            rules: {
                maxlength: 4
            }
        },
        middleTelno: {
            label: '중간전화번호',
            rules: {
                maxlength: 4
            }
        },
        endTelno: {
            label: '마지막전화번호',
            rules: {
                maxlength: 4
            }
        },
        qestnSj: {
            label: '질문제목',
            rules: {
                required: true,
                maxlength: 250
            }
        },
        qestnCn: {
            label: '질문내용',
            rules: {
                required: true,
                maxlength: 2500
            }
        },
        answerCn: {
            label: '답변내용',
            rules: {
                required: true,
                maxlength: 2500
            }
        }
    };
    return EgovValidation.validateForm(form, rules);
}

// FAQ 관리
function validateFaqManageVO(form) {
    const rules = {
        qestnSj: {
            label: '질문제목',
            rules: {
                required: true,
                maxlength: 250
            }
        },
        qestnCn: {
            label: '질문내용',
            rules: {
                required: true,
                maxlength: 2500
            }
        },
        answerCn: {
            label: '답변내용',
            rules: {
                required: true,
                maxlength: 2500
            }
        }
    };
    return EgovValidation.validateForm(form, rules);
}

// 개인정보보호정책
function validateIndvdlInfoPolicy(form) {
    const rules = {
        indvdlInfoPolicyNm: {
            label: '개인정보보호정책명',
            rules: {
                required: true,
                maxlength: 100
            }
        },
        indvdlInfoPolicyDc: {
            label: '개인정보보호정책설명',
            rules: {
                required: true,
                maxlength: 1000
            }
        }
    };
    return EgovValidation.validateForm(form, rules);
}

// 약관 관리
function validateStplatManageVO(form) {
    const rules = {
        stplatNm: {
            label: '약관명',
            rules: {
                required: true,
                maxlength: 100
            }
        },
        stplatCn: {
            label: '약관내용',
            rules: {
                required: true,
                maxlength: 4000
            }
        }
    };
    return EgovValidation.validateForm(form, rules);
}

// 설문 응답 정보
function validateQustnrRespondInfoVO(form) {
    const rules = {
        qestnrId: {
            label: '설문ID',
            rules: {
                required: true
            }
        },
        qestnrTmplatId: {
            label: '설문템플릿ID',
            rules: {
                required: true
            }
        },
        qestnrQesitmId: {
            label: '설문문항ID',
            rules: {
                required: true
            }
        },
        qestnrQesitmId: {
            label: '설문문항ID',
            rules: {
                required: true
            }
        }
    };
    return EgovValidation.validateForm(form, rules);
}

// 설문 문항 관리
function validateQustnrQestnManageVO(form) {
    const rules = {
        qestnrId: {
            label: '설문ID',
            rules: {
                required: true
            }
        },
        qestnrTmplatId: {
            label: '설문템플릿ID',
            rules: {
                required: true
            }
        },
        qestnSn: {
            label: '설문문항순번',
            rules: {
                required: true,
                integer: true
            }
        },
        qestnTyCode: {
            label: '설문문항유형코드',
            rules: {
                required: true
            }
        },
        qestnCn: {
            label: '설문문항내용',
            rules: {
                required: true,
                maxlength: 1000
            }
        }
    };
    return EgovValidation.validateForm(form, rules);
}

// 설문 관리
function validateQustnrManageVO(form) {
    const rules = {
        qestnrSj: {
            label: '설문제목',
            rules: {
                required: true,
                maxlength: 250
            }
        },
        qestnrPurps: {
            label: '설문목적',
            rules: {
                required: true,
                maxlength: 1000
            }
        },
        qestnrWritngGuidanceCn: {
            label: '설문작성안내 내용',
            rules: {
                required: true,
                maxlength: 2000
            }
        },
        qestnrTrget: {
            label: '설문대상',
            rules: {
                required: true
            }
        },
        qestnrBeginDe: {
            label: '설문기간 시작일자',
            rules: {
                required: true
            }
        },
        qestnrEndDe: {
            label: '설문기간 종료일자',
            rules: {
                required: true
            }
        }
    };
    return EgovValidation.validateForm(form, rules);
}

// 설문 템플릿 관리
function validateQustnrTmplatManageVO(form) {
    const rules = {
        qestnrTmplatNm: {
            label: '설문템플릿명',
            rules: {
                required: true,
                maxlength: 100
            }
        },
        qestnrTmplatCn: {
            label: '설문템플릿설명',
            rules: {
                required: true,
                maxlength: 1000
            }
        }
    };
    return EgovValidation.validateForm(form, rules);
}

// 설문 문항 관리
function validateQustnrItemManageVO(form) {
    const rules = {
        qestnrId: {
            label: '설문ID',
            rules: {
                required: true
            }
        },
        qestnrTmplatId: {
            label: '설문템플릿ID',
            rules: {
                required: true
            }
        },
        qestnrQesitmId: {
            label: '설문문항ID',
            rules: {
                required: true
            }
        },
        iemSn: {
            label: '항목순번',
            rules: {
                required: true,
                integer: true
            }
        },
        iemCn: {
            label: '항목내용',
            rules: {
                required: true,
                maxlength: 1000
            }
        }
    };
    return EgovValidation.validateForm(form, rules);
}

// 설문 응답 관리
function validateQustnrRespondManageVO(form) {
    const rules = {
        qestnrId: {
            label: '설문ID',
            rules: {
                required: true
            }
        },
        qestnrTmplatId: {
            label: '설문템플릿ID',
            rules: {
                required: true
            }
        },
        qestnrQesitmId: {
            label: '설문문항ID',
            rules: {
                required: true
            }
        },
        respondNm: {
            label: '응답자명',
            rules: {
                required: true,
                maxlength: 50
            }
        },
        respondAnswerCn: {
            label: '응답답변내용',
            rules: {
                required: true,
                maxlength: 1000
            }
        }
    };
    return EgovValidation.validateForm(form, rules);
}

// 배너 관리
function validateBanner(form) {
    const rules = {
        bannerNm: {
            label: '배너명',
            rules: {
                required: true,
                maxlength: 100
            }
        },
        bannerUrl: {
            label: '배너URL',
            rules: {
                required: true,
                maxlength: 255
            }
        },
        bannerDc: {
            label: '배너설명',
            rules: {
                maxlength: 500
            }
        },
        bannerBeginDe: {
            label: '배너시작일',
            rules: {
                required: true
            }
        },
        bannerEndDe: {
            label: '배너종료일',
            rules: {
                required: true
            }
        }
    };
    return EgovValidation.validateForm(form, rules);
}
