/**
 * Convert a single file-input element into a 'multiple' input list
 * Usage:
 *
 *   1. Create a file input element (no name)
 *      eg. <input type="file" id="first_file_element">
 *
 *   2. Create a DIV for the output to be written to
 *      eg. <div id="files_list"></div>
 *
 *   3. Instantiate a MultiSelector object, passing in the DIV and an (optional) maximum number of files
 *      eg. var multi_selector = new MultiSelector( document.getElementById( 'files_list' ), 3 );
 *
 *   4. Add the first element
 *      eg. multi_selector.addElement( document.getElementById( 'first_file_element' ) );
 */

function MultiSelector( list_target, max ){

	// Where to write the list
	this.list_target = list_target;
	// How many selected files (실제 선택된 파일 수)
	this.count = 0;
	// Element ID counter (DOM 요소 생성용)
	this.id = 0;
	// Total created elements (생성된 전체 요소 수)
	this.total_elements = 0;
	// Is there a maximum?
	if( max ){
		this.max = parseInt(max);
	} else {
		this.max = 3; // 기본값 3개로 변경
	};
	
	// 선택된 파일 목록 관리
	this.selected_files = [];
	
	/**
	 * Add a new file input element
	 */
	this.addElement = function( element ){

		// Make sure it's a file input element
		if( element.tagName == 'INPUT' && element.type == 'file' ){

			// Element name
			element.name = 'file_' + this.id++;
			element.setAttribute('data-file-id', this.id - 1);

			// Add reference to this object
			element.multi_selector = this;
			
			// 전체 생성된 요소 수 증가
			this.total_elements++;

			// What to do when a file is selected
			element.onchange = function(){
				
				// 파일이 선택되었는지 확인
				if(this.value && this.value.length > 0) {
					
					// 최대 파일 수 체크
					if(this.multi_selector.count >= this.multi_selector.max) {
						alert('최대 ' + this.multi_selector.max + '개의 파일만 첨부할 수 있습니다.');
						this.value = ''; // 선택 취소
						return false;
					}
					
					// 선택된 파일 수 증가
					this.multi_selector.count++;
					
					// 파일 정보를 배열에 저장
					this.multi_selector.selected_files.push({
						element: this,
						name: this.value,
						id: this.getAttribute('data-file-id')
					});
					
					// Update list
					this.multi_selector.addListRow( this );
					
					// Hide this element
					this.style.position = 'absolute';
					this.style.left = '-1000px';
					this.style.top = '-1000px';
					this.style.display = 'none';
					this.style.visibility = 'hidden';
					this.style.width = '0';
					this.style.height = '0';
					this.style.overflow = 'hidden';
					
					// 최대 개수에 도달하지 않았으면 새로운 파일 입력 요소 생성
					if(this.multi_selector.count < this.multi_selector.max) {
						// New file input
						var new_element = document.createElement( 'input' );
						new_element.type = 'file';
						
						// Add new element
						this.parentNode.insertBefore( new_element, this );
						
						// Apply 'update' to element
						this.multi_selector.addElement( new_element );
						
						new_element.onkeypress = function(){
							return false;
						};
					}
				}
			};
			
			// Most recent element
			this.current_element = element;
			
		} else {
			// This can only be applied to file input elements!
			alert( 'Error: not a file input element' );
		};

	};

	/**
	 * Add a new row to the list of files
	 */
	this.addListRow = function( element ){

		// Row div
		var new_row = document.createElement( 'div' );
		new_row.className = 'file-item';
		new_row.style.marginBottom = '5px';

		// Delete button
		var new_row_button = document.createElement( 'input' );
		new_row_button.type = 'button';
		new_row_button.value = '삭제';
		new_row_button.style.marginLeft = '10px';
		new_row_button.className = 'btn btn_small';

		// References
		new_row.element = element;
		var file_id = element.getAttribute('data-file-id');

		// Delete function
		new_row_button.onclick= function(){
			var multi_selector = this.parentNode.element.multi_selector;
			var element_to_remove = this.parentNode.element;
			var file_id = element_to_remove.getAttribute('data-file-id');

			// Remove element from form
			if(element_to_remove.parentNode) {
				element_to_remove.parentNode.removeChild( element_to_remove );
			}

			// Remove this row from the list
			this.parentNode.parentNode.removeChild( this.parentNode );

			// Decrement counter
			multi_selector.count--;
			
			// selected_files 배열에서 제거
			for(var i = 0; i < multi_selector.selected_files.length; i++) {
				if(multi_selector.selected_files[i].id == file_id) {
					multi_selector.selected_files.splice(i, 1);
					break;
				}
			}

			// 파일을 삭제했으므로 새로운 입력 필드가 필요한 경우 생성
			if(multi_selector.count < multi_selector.max && 
			   !multi_selector.hasVisibleFileInput()) {
				var new_element = document.createElement( 'input' );
				new_element.type = 'file';
				
				// 첫 번째 파일 입력 필드의 부모에 추가
				var file_container = document.getElementById('file_upload_posbl');
				if(file_container) {
					file_container.appendChild(new_element);
					multi_selector.addElement( new_element );
				}
			}

			return false;
		};

		// 파일명만 표시 (전체 경로에서 파일명만 추출)
		var fileName = element.value;
		if(fileName.lastIndexOf('\\') !== -1) {
			fileName = fileName.substring(fileName.lastIndexOf('\\') + 1);
		}
		if(fileName.lastIndexOf('/') !== -1) {
			fileName = fileName.substring(fileName.lastIndexOf('/') + 1);
		}
		
		// Set row value
		var fileNameSpan = document.createElement('span');
		fileNameSpan.innerHTML = fileName;
		new_row.appendChild(fileNameSpan);

		// Add button
		new_row.appendChild( new_row_button );

		// Add it to the list
		this.list_target.appendChild( new_row );
	};
	
	/**
	 * 현재 보이는 파일 입력 필드가 있는지 확인
	 */
	this.hasVisibleFileInput = function() {
		var inputs = document.querySelectorAll('input[type="file"]');
		for(var i = 0; i < inputs.length; i++) {
			if(inputs[i].style.display !== 'none' && 
			   inputs[i].style.visibility !== 'hidden' && 
			   inputs[i].offsetParent !== null) {
				return true;
			}
		}
		return false;
	};
	
	/**
	 * 현재 선택된 파일 개수 반환
	 */
	this.getFileCount = function() {
		return this.count;
	};
	
	/**
	 * 최대 파일 개수 반환
	 */
	this.getMaxFileCount = function() {
		return this.max;
	};

};