
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<%@include file="../include/header.jsp" %>

<style type="text/css">
    .popup {
        position: absolute;
    }
    .back {
        background-color: grey;
        opacity: 0.5;
        width: 100%;
        height: 300%;
        overflow: hidden;
        z-index: 1101;
    }
    .front {
        z-index: 1110;
        opacity: 1;
        border: 1px;
        margin: auto;
    }
    .show {
        position: relative;
        max-width: 1200px;
        max-height: 800px;
        overflow: auto;
    }
</style>

<div class='popup back' style="display:none;"></div>
<div id="popup_front" class='popup front' style="display:none;">
    <img id="popup_img">
</div>

<!-- Main content -->
<section class="content">
    <div class="row">
        <!-- left column -->
        <div class="col-md-12">
            <!-- general form elements -->
            <div class="box box-primary">
                <div class="box-header">
                    <h3 class="box-title">READ BOARD</h3>
                </div><!-- /.box-header -->

                <form role="form" action="modifyPage" method="post">

                    <input type='hidden' name='bno' value="${boardVO.bno}">
                    <input type='hidden' name='page' value="${cri.page}">
                    <input type='hidden' name='perPageNum' value="${cri.perPageNum}">
                    <input type="hidden" name="searchType" value="${cri.searchType}">
                    <input type="hidden" name="keyword" value="${cri.keyword}">

                </form>

                <div class="box-body">
                    <div class="form-group">
                        <label>Title</label>
                        <input type="text" name='title' class="form-control"
                               value="${boardVO.title}" readonly="readonly">
                    </div>
                    <div class="form-group">
                        <label>Content</label>
                        <textarea class="form-control" name="content" rows="3"
                                  readonly="readonly">${boardVO.context}</textarea>
                    </div>
                    <div class="form-group">
                        <label>Writer</label>
                        <input type="text" name="writer" class="form-control"
                               value="${boardVO.writer}" readonly="readonly">
                    </div>
                </div><!-- /.box-body -->

                <div class="box-footer">
                    <ul class="mailbox-attachments clearfix uploadedList"></ul>
                    <c:if test="${login.uid == boardVO.writer}">
                        <button type="submit" class="btn btn-warning" id="modify">Modify</button>
                        <button type="submit" class="btn btn-danger" id="remove">REMOVE</button>
                    </c:if>
                    <button type="submit" class="btn btn-primary" id="go-list">GO LIST</button>
                </div>


                <script>
                    $(document).ready(function () {
                        var formObj = $("form[role='form']");
                        console.log(formObj);
                        $("#modify").on("click", function () {
                            formObj.attr("action", "/sboard/modifyPage");
                            formObj.attr("method", "get");
                            formObj.submit();
                        });
                        $("#remove").on("click", function () {
                            debugger;
                            var replyCnt = $("#replycntSmall").html().replace("[", "").replace("]", "").trim()
                            if (replyCnt > 0) {
                                alert("댓글이 달린 게시물은 삭제할 수 없습니다.");
                                return;
                            }
                            var arr = [];
                            $(".uploadedList li").each(function (index) {
                                arr.push($(this).attr("data-src"));
                            });
                            if (arr.length > 0) {
                                $.post("/deleteAllFiles", {files: arr}, function () {
                                });
                            }
                            formObj.attr("action", "/sboard/removePage");
                            formObj.submit();
                        });
                        $("#go-list").on("click", function () {
                            formObj.attr("method", "get");
                            formObj.attr("action", "/sboard/list");
                            formObj.submit();
                        });
                    });
                </script>


            </div><!-- /.box -->
        </div><!--/.col (left) -->

    </div>   <!-- /.row -->

    <div class="row">
        <div class="col-md-12">
            <div class="box box-success">
                <div class="box-header">
                    <h3 class="box-title">ADD NEW REPLY</h3>
                </div>
                <c:if test="${not empty login}">
                    <div class="box-body">
                        <label>Writer</label>
                        <input class="form-control" type="text" id="newReplyWriter" value="${login.uid}" readonly="readonly">
                        <label>Reply Text</label>
                        <input class="form-control" type="text" placeholder="REPLY TEXT" id="newReplyText">
                    </div>
                    <div class="box-footer">
                        <button type="button" class="btn btn-primary" id="replyAddBtn">ADD REPLY</button>
                    </div>
                </c:if>

                <c:if test="${empty login}">
                    <div><a href="javascript:goLogin()">Please Login</a></div>
                </c:if>
            </div>

            <ul class="timeline">
                <li class="time-label" id="repliesDiv">
                    <span class="bg-green">
                        Replies List <small id="replycntSmall"> [ ${boardVO.replycnt} ]</small>
                    </span></li>
            </ul>

            <div class="text-center">
                <ul id="pagination" class="pagination pagination-sm no-margin">

                </ul>
            </div>
        </div>

        <!-- Modal -->
        <div id="modifyModal" class="modal modal-primary fade" role="dialog">
            <div class="modal-dialog">
                <!-- Model contents -->
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title"></h4>
                    </div>
                    <div class="modal-body" data-rno>
                        <p><input type="text" id="replytext" class="form-control"></p>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-info" id="replyModBtn">Modify</button>
                        <button type="button" class="btn btn-danger" id="replyDelBtn">Delete</button>
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>

        <script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/4.0.5/handlebars.js"></script>
        <script src="/resources/js/upload.js"></script>

        <script id="template" type="text/x-handlebars-template">
            {{#each .}}
            <li class="replyLi" data-rno={{rno}}>
                <i class="fa fa-comments bg-blue"></i>
                <div class="timeline-item">
                    <span class="time">
                        <i class="fa fa-clock-o"></i>{{prettifyDate regdate}}
                    </span>
                    <h3 class="timeline-header">
                        <string>{{rno}}</string>
                        - {{replyer}}
                    </h3>
                    <div class="timeline-body">
                        {{replytext}}
                    </div>
                    <div class="timeline-footer">
                        <a class="btn btn-primary btn-xs" data-toggle="modal" data-target="#modifyModal">Modify</a>
                    </div>
                </div>
            </li>
            {{/each}}
        </script>

        <script id="templateAttach" type="text/x-handlebars-template">
            <li data-src="{{fullName}}">
                <span class="mailbox-attachment-icon has-img">
                    <img src="{{imgsrc}}" alt="Attachment">
                </span>
                <div class="mailbox-attachment-info">
                    <a href="{{getLink}}" class="mailbox-attachment-name">{{fileName}}</a>
                </div>
            </li>
        </script>

        <script>
            Handlebars.registerHelper("prettifyDate", function (timeValue) {
                var dateObj = new Date(timeValue);
                var year = dateObj.getFullYear();
                var month = dateObj.getMonth() + 1;
                var date = dateObj.getDate();
                return year + "/" + month + "/" + date;
            });
            var bno = ${boardVO.bno};
            var replyPage = 1;
            function getPage(pageInfo) {
                $.getJSON(pageInfo, function (data) {
                    printData(data.list, $("#repliesDiv"), $("#template"));
                    printPaging(data.pageMaker, $(".pagination"));
                    $('#modifyModal').modal('hide');
                    $('#replycntSmall').html(" [ " + data.pageMaker.totalCount + " ] ");
                });
            }
            var printData = function (replyArr, target, templateObject) {
                var template = Handlebars.compile(templateObject.html());
                var html = template(replyArr);
                $(".replyLi").remove();
                target.after(html);
            };
            var printPaging = function (pageMaker, target) {
                var str = "";
                if (pageMaker.prev) {
                    str += "<li><a href='" + (pageMaker.startPage - 1) + "'> << </a></li>";
                }
                for (var i = pageMaker.startPage, len = pageMaker.endPage; i <= len; i++) {
                    var strClass = pageMaker.cri.page === i ? 'class=active' : '';
                    str += "<li " + strClass + "><a href='" + i + "'>" + i + "</a></li>"
                }
                if (pageMaker.next) {
                    str += "<li><a href='" + (pageMaker.endPage + 1) + "'> >> </a></li>";
                }
                target.html(str);
            }
            // 댓글 리스트를 불러온다
            $("#repliesDiv").on("click", function () {
                if ($(".timeline li").size() > 1) {
                    return;
                }
                getPage("/replies/" + bno + "/1");
            });
            // 페이징 이벤트 처리
            $(".pagination").on("click", "li a", function (event) {
                event.preventDefault();
                replyPage = $(this).attr("href");
                getPage("/replies/" + bno + "/" + replyPage);
            });
            // 댓글 등록 이벤트 처리
            $("#replyAddBtn").on("click", function (event) {
                event.preventDefault();
                var replyerObj = $("#newReplyWriter");
                var replytextObj = $("#newReplyText");
                var replyer = replyerObj.val();
                var replytext = replytextObj.val();
                $.ajax({
                    type: 'post',
                    url: '/replies',
                    headers: {
                        "Content-Type": "application/json",
                        "X-HTTP-Method-Override": "POST"
                    },
                    dataType: 'text',
                    data: JSON.stringify({
                        bno: bno,
                        replyer: replyer,
                        replytext: replytext
                    }),
                    success: function (result) {
                        console.log(result);
                        if (result === 'SUCCESS') {
                            alert('등록되었습니다');
                            replyPage = 1;
                            getPage("/replies/" + bno + "/" + replyPage);
                            replyerObj.val("");
                            replytextObj.val("");
                        }
                    }
                });
            });
            // 각 댓글의 버튼 이벤트 처리
            $(".timeline").on("click", ".replyLi", function (event) {
                var reply = $(this);
                $("#replytext").val(reply.find('.timeline-body').text().trim());
                $(".modal-title").html(reply.attr("data-rno"));
            });
            // 댓글 수정
            $("#replyModBtn").on("click", function () {
                var rno = $('.modal-title').html();
                var replytext = $('#replytext').val();
                $.ajax({
                    type: 'put',
                    url: '/replies/' + rno,
                    headers: {
                        "Content-Type": "application/json",
                        "X-HTTP-Method-Override": "PUT"
                    },
                    data: JSON.stringify({
                        replytext: replytext
                    }),
                    dataType: 'text',
                    success: function (result) {
                        console.log('result:' + result);
                        if (result === 'SUCCESS') {
                            alert('수정 되었습니다.');
                            getPage("/replies/" + bno + "/" + replyPage);
                        }
                    }
                });
            });
            // 댓글 삭제
            $('#replyDelBtn').on('click', function () {
                var rno = $('.modal-title').html();
                var replytext = $('#replytext').val();
                $.ajax({
                    type: 'delete',
                    url: '/replies/' + rno,
                    headers: {
                        "Content-Type": "application/json",
                        "X-HTTP-Method-Override": "DELETE"
                    },
                    dataType: 'text',
                    success: function (result) {
                        console.log(result);
                        if (result === 'SUCCESS') {
                            alert('삭제 되었습니다.');
                            getPage('/replies/' + bno + '/' + replyPage);
                        }
                    }
                });
            });
            // 첨부파일 조회
            var templateAttach = Handlebars.compile($("#templateAttach").html());
            $.getJSON("/sboard/getAttach/" + bno, function (list) {
                $(list).each(function () {
                    var fileInfo = getFileInfo(this);
                    var html = templateAttach(fileInfo);
                    $(".uploadedList").append(html);
                });
            });
            // 이미지 파일 원본 보기
            $(".uploadedList").on("click", ".mailbox-attachment-info a", function (event) {
                var fileLink = $(this).attr('href');
                if (checkImageType(fileLink)) {
                    event.preventDefault();
                    var imgTag = $("#popup_img");
                    imgTag.attr("src", fileLink);
                    console.log(imgTag.attr("src"));
                    $(".popup").show('slow');
                    imgTag.addClass('show');
                }
            });
            $("#popup_img").on("click", function () {
                $(".popup").hide('slow');
            });
        </script>
    </div>
</section>
<!-- /.content -->

<%@include file="../include/footer.jsp" %>




<%-- <%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%> 
<%@include file="../include/header.jsp"%>
<script type="text/javascript" src="/resources/js/upload.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
<!-- Main content -->

    <style type="text/css">
    .popup {position: absolute;}
    .back { background-color: gray; opacity:0.5; width: 100%; height: 300%; overflow:hidden;  z-index:1101;}
    .front { 
       z-index:1110; opacity:1; boarder:1px; margin: auto; 
      }
     .show{
       position:relative;
       max-width: 1200px; 
       max-height: 800px; 
       overflow: auto;       
     } 
  	
    </style>
        <div class='popup back' style="display:none;"></div>
    <div id="popup_front" class='popup front' style="display:none;">
     <img id="popup_img">
    </div>
<section class="content">
	<div class="row">
		<!-- left column -->
		<div class="col-md-12">
			<!-- general form elements -->
			<div class="box box-primary">
				<div class="box-header">
					<h3 class="box-title">READ BOARD</h3>
				</div>
				<!-- /.box-header -->

				<form role="form" action="modifyPage" method="post">

					<input type='hidden' name='bno' value="${boardVO.bno}"> <input
						type='hidden' name='page' value="${cri.page}"> <input
						type='hidden' name='perPageNum' value="${cri.perPageNum}">
					<input type='hidden' name='searchType' value="${cri.searchType}">
					<input type='hidden' name='keyword' value="${cri.keyword}">

				</form>

				<div class="box-body">
					<div class="form-group">
						<label for="exampleInputEmail1">Title</label> <input type="text"
							name='title' class="form-control" value="${boardVO.title}"
							readonly="readonly">
					</div>
					<div class="form-group">
						<label for="exampleInputPassword1">Content</label>
						<textarea class="form-control" name="content" rows="3"
							readonly="readonly">${boardVO.context}</textarea>
					</div>
					<div class="form-group">
						<label for="exampleInputEmail1">Writer</label> <input type="text"
							name="writer" class="form-control" value="${boardVO.writer}"
							readonly="readonly">
					</div>
				</div>
				<!-- /.box-body -->
				
			  <div class="box-footer">
				<div><hr></div>
				
  				  <ul class="mailbox-attachments clearfix uploadedList"></ul>
				<c:if test="${login.uid == boardVO.writer}">
			    <button type="submit" class="btn btn-warning" id="modifyBtn">Modify</button>
			    <button type="submit" class="btn btn-danger" id="removeBtn">REMOVE</button>
			    </c:if>
			    <button type="submit" class="btn btn-primary" id="goListBtn">GO LIST </button>
			  </div>



			</div>
			<!-- /.box -->
		</div>
		<!--/.col (left) -->

	</div>
	<!-- /.row -->



	<div class="row">
		<div class="col-md-12">

			<div class="box box-success">
				<div class="box-header">
					<h3 class="box-title">ADD NEW REPLY</h3>
				</div>
				
				 <c:if test="${not empty login}">
				<div class="box-body">
					<label for="exampleInputEmail1">Writer</label> <input
						class="form-control"type="text" 
						id="newReplyWriter" value="${login.uid}" readonly="readonly" >
						 <label for="exampleInputEmail1">Reply
						Text</label> <input class="form-control" type="text"
						placeholder="REPLY TEXT" id="newReplyText">
				</div>
				
				
				<!-- /.box-body -->
				<div class="box-footer">
					<button type="button" class="btn btn-primary" id="replyAddBtn">ADD REPLY</button>
				</div>
				</c:if>
				  <c:if test="${empty login}">
   				 <div class="box-body">
      				<div><a href="javascript:goLogin();" >Login Please</a></div>
    		</div>
 		 </c:if>	
	
	</div>


			<!-- The time line -->
			<ul class="timeline">
				<!-- timeline time label -->
				<li class="time-label" id="repliesDiv">
				<span class="bg-green">
						Replies List<small id='replycntSmall'> [ ${boardVO.replycnt} ] </small> 
						</span></li>
			</ul>

			<div class='text-center'>
				<ul id="pagination" class="pagination pagination-sm no-margin ">

				</ul>
			</div>

		</div>
		<!-- /.col -->
	</div>
	<!-- /.row -->


          
<!-- Modal -->
<div id="modifyModal" class="modal modal-primary fade" role="dialog">
  <div class="modal-dialog">
    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title"></h4>
      </div>
      <div class="modal-body" data-rno>
        <p><input type="text" id="replytext" class="form-control"></p>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-info" id="replyModBtn">Modify</button>
        <button type="button" class="btn btn-danger" id="replyDelBtn">DELETE</button>
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>      
	
	
</section>
<!-- /.content -->
<script id="templateAttach" type="text/x-handlebars-template">
<li data-src='{{fullName}}'>
  <span class="mailbox-attachment-icon has-img"><img src="{{imgsrc}}" alt="Attachment"></span>
  <div class="mailbox-attachment-info">
	<a href="{{getLink}}" class="mailbox-attachment-name">{{fileName}}</a>
	</span>
  </div>
</li>                
</script>  


          
<script id="template" type="text/x-handlebars-template">
				{{#each .}}
	         <li class="replyLi" data-rno={{rno}}>
             <i class="fa fa-comments bg-blue"></i>
             <div class="timeline-item" >
                <span class="time">
                  <i class="fa fa-clock-o"></i>{{prettifyDate regdate}}
                </span>
                <h3 class="timeline-header"><strong>{{rno}}</strong> -{{replyer}}</h3>
                <div class="timeline-body">{{replytext}} </div>
								<div class="timeline-footer">
								{{#eqReplyer replyer }}
                  <a class="btn btn-primary btn-xs" 
									data-toggle="modal" data-target="#modifyModal">Modify</a>
								{{/eqReplyer}}
							  </div>
	            </div>			
           </li>
        {{/each}}
</script> 



<script>

		Handlebars.registerHelper("eqReplyer", function(replyer, block) {
			var accum = '';
			if (replyer == '${login.uid}') {
				accum += block.fn();
			}
			return accum;
		});
		//댓글 수정과 삭제 작은 로그인한 사용자 본인이 할수있도록 // 



	Handlebars.registerHelper("prettifyDate", function(timeValue) {
		var dateObj = new Date(timeValue);
		var year = dateObj.getFullYear();
		var month = dateObj.getMonth() + 1;
		var date = dateObj.getDate();
		return year + "/" + month + "/" + date;
	});

	var printData = function(replyArr, target, templateObject) {

		var template = Handlebars.compile(templateObject.html());

		var html = template(replyArr);
		$(".replyLi").remove();
		target.after(html);

	}

/* 	var bno = ${boardVO.bno};
	
	var replyPage = 1;

	function getPage(pageInfo) {

		$.getJSON(pageInfo, function(data) {
			printData(data.list, $("#repliesDiv"), $('#template'));
			printPaging(data.pageMaker, $(".pagination"));

			$("#modifyModal").modal('hide');

		});
	} */
	var bno = ${boardVO.bno};

	var replyPage = 1;

	function getPage(pageInfo) {

		$.getJSON(pageInfo, function(data) {
			printData(data.list, $("#repliesDiv"), $('#template'));
			printPaging(data.pageMaker, $(".pagination"));

			$("#modifyModal").modal('hide');
			$("#replycntSmall").html("[ " + data.pageMaker.totalCount + " ]");

		});
	}

	var printPaging = function(pageMaker, target) {

		var str = "";

		if (pageMaker.prev) {
			str += "<li><a href='" + (pageMaker.startPage - 1)
					+ "'> << </a></li>";
		}

		for (var i = pageMaker.startPage, len = pageMaker.endPage; i <= len; i++) {
			var strClass = pageMaker.cri.page == i ? 'class=active' : '';
			str += "<li "+strClass+"><a href='"+i+"'>" + i + "</a></li>";
		}

		if (pageMaker.next) {
			str += "<li><a href='" + (pageMaker.endPage + 1)
					+ "'> >> </a></li>";
		}

		target.html(str);
	};

	$("#repliesDiv").on("click", function() {

		if ($(".timeline li").size() > 1) {
			return;
		}
		getPage("/replies/" + bno + "/1");

	});
	

	$(".pagination").on("click", "li a", function(event){
		
		event.preventDefault();
		
		replyPage = $(this).attr("href");
		
		getPage("/replies/"+bno+"/"+replyPage);
		
	});
	

	$("#replyAddBtn").on("click",function(){
		 
		 var replyerObj = $("#newReplyWriter");
		 var replytextObj = $("#newReplyText");
		 var replyer = replyerObj.val();
		 var replytext = replytextObj.val();
		
		  
		  $.ajax({
				type:'post',
				url:'/replies/',
				headers: { 
				      "Content-Type": "application/json",
				      "X-HTTP-Method-Override": "POST" },
				dataType:'text',
				data: JSON.stringify({bno:bno, replyer:replyer, replytext:replytext}),
				success:function(result){
					console.log("result: " + result);
					if(result == 'SUCCESS'){
						alert("등록 되었습니다.");
						replyPage = 1;
						getPage("/replies/"+bno+"/"+replyPage );
						replyerObj.val("");
						replytextObj.val("");
					}
			}});
	});


	$(".timeline").on("click", ".replyLi", function(event){
		
		var reply = $(this);
		
		$("#replytext").val(reply.find('.timeline-body').text());
		$(".modal-title").html(reply.attr("data-rno"));
		
	});
	
	

	$("#replyModBtn").on("click",function(){
		  
		  var rno = $(".modal-title").html();
		  var replytext = $("#replytext").val();
		  
		  $.ajax({
				type:'put',
				url:'/replies/'+rno,
				headers: { 
				      "Content-Type": "application/json",
				      "X-HTTP-Method-Override": "PUT" },
				data:JSON.stringify({replytext:replytext}), 
				dataType:'text', 
				success:function(result){
					console.log("result: " + result);
					if(result == 'SUCCESS'){
						alert("수정 되었습니다.");
						getPage("/replies/"+bno+"/"+replyPage );
					}
			}});
	});

	$("#replyDelBtn").on("click",function(){
		  
		  var rno = $(".modal-title").html();
		  var replytext = $("#replytext").val();
		  
		  $.ajax({
				type:'delete',
				url:'/replies/'+rno,
				headers: { 
				      "Content-Type": "application/json",
				      "X-HTTP-Method-Override": "DELETE" },
				dataType:'text', 
				success:function(result){
					console.log("result: " + result);
					if(result == 'SUCCESS'){
						alert("삭제 되었습니다.");
						getPage("/replies/"+bno+"/"+replyPage );
					}
			}});
	});
	
</script>


<script>
$(document).ready(function(){
	
	var formObj = $("form[role='form']");
	
	console.log(formObj);
	
	$("#modifyBtn").on("click", function(){
		formObj.attr("action", "/sboard/modifyPage");
		formObj.attr("method", "get");		
		formObj.submit();
	});
	
/* 	$("#removeBtn").on("click", function(){
		formObj.attr("action", "/sboard/removePage");
		formObj.submit();
	}); */
	
	$("#removeBtn").on("click", function(){
		
		var replyCnt =  $("#replycntSmall").html();
		
		if(replyCnt > 0 ){
			alert("댓글이 달린 게시물을 삭제할 수 없습니다.");
			return;
		}	
		
		var arr = [];
		$(".uploadedList li").each(function(index){
			 arr.push($(this).attr("data-src"));
		});
		
		if(arr.length > 0){
			$.post("/deleteAllFiles",{files:arr}, function(){
				
			});
		}
		
		formObj.attr("action", "/sboard/removePage");
		formObj.submit();
	});
	
	$("#goListBtn ").on("click", function(){
		formObj.attr("method", "get");
		formObj.attr("action", "/sboard/list");
		formObj.submit();
	});
	
	var bno = ${boardVO.bno};
	var template = Handlebars.compile($("#templateAttach").html());
	
	$.getJSON("/sboard/getAttach/"+bno,function(list){
		$(list).each(function(){
			
			var fileInfo = getFileInfo(this);
			
			var html = template(fileInfo);
			
			 $(".uploadedList").append(html);
			
		});
	});
	


	$(".uploadedList").on("click", ".mailbox-attachment-info a", function(event){
		
		var fileLink = $(this).attr("href");
		
		if(checkImageType(fileLink)){
			
			event.preventDefault();
					
			var imgTag = $("#popup_img");
			imgTag.attr("src", fileLink);
			
			console.log(imgTag.attr("src"));
					
			$(".popup").show('slow');
			imgTag.addClass("show");		
		}	
	});
	
	$("#popup_img").on("click", function(){
		
		$(".popup").hide('slow');
		
	});	
	
});
</script>






<%@include file="../include/footer.jsp"%> --%>
