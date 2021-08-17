<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%-- 배포된 웹 애플리케이션의 최상위 주소를 간단히 얻어올 수 있도록 
     application 범위로 변수를 하나 생성 --%>
<c:set var="contextPath" scope="application"
	value="${pageContext.servletContext.contextPath}" />

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>내가 쓴 글 - 자유게시판</title>
<style>
a {
	text-decoration: none;
	color: inherit;
}

a:hover {
	text-decoration: none;
	color: inherit;
	font-weight: bold;
}

.myPage-body {
	display: flex;
	align-items: center;
}

.myPage-main {
	width: 100%;
	height: 100%;
	display: flex;
	flex-direction: column;
	justify-content: center;
	align-items: center;
	margin-top: 100px;
}

.myPage-main h2 {
	margin-bottom: 30px;
}

.myPage-main>div {
	width: 90%;
}

.myPage-postBtnArea {
	margin-bottom: 20px;
}

.myPage-main table {
	text-align: center;
}

.myPage-sideBar {
	display: flex;
	flex-direction: column;
}

.myPage-pagination {
	display: flex;
	justify-content: center;
	align-items: center;
	list-style: none;
	width: 100%;
	padding: 0px;
}

.myPage-pagination a {
	border: 1px solid rgba(0, 0, 0, 0.3);
	padding: 5px 13px;
	margin: 0px 2px;
	border-radius: 5px;
}

.focus-page {
	font-weight: bold;
}

.order-check {
	color: #FCC77F;
}

.table {
	table-layout: fixed;
}

.boardTitle {
	virtical-align: middle;
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: nowrap;
}

#searchForm {
	display: flex;
	justify-content: center;
	width: 70%;	
}
#search-container {
	display: flex;
	justify-content: center;
}
.searchForm-container {
	display: flex;
	justify-content: center;
	align-items: center;
	width: 70%;
}
.searchForm-container * {
	margin-right: 3px;
}

.searchForm-container input {
	width: 150%;
}
.searchForm-container button {
	width: 50%;
}
</style>
</head>

<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
<jsp:include page="/WEB-INF/views/myPage/sideBar.jsp"></jsp:include>

<body class="myPage-body">

	<%-- 검색 상태 유지를 위한 쿼리스트링용 변수 선언 --%>
	<c:if test="${!empty param.sv }">
		<c:set var="searchValue" value="&sv=${param.sv}" />
		<c:set var="searchStr"
			value="&sc=${param.sc}&sk=${param.sk}${searchValue }" />
	</c:if>

	<c:if test="${!empty param.order }">
		<c:set var="order" value="&order=${param.order}" />
	</c:if>

	<main class="myPage-main">
		<h2>내가 쓴 게시글</h2>
		<div class="myPage-postBtnArea">
			<a href="${contextPath }/myPage/post" class="btn btn-secondary">자유게시판</a>
			<a href="${contextPath }/myPage/qnaBoard" class="btn btn-light">문의게시판</a>
			<a href="${contextPath }/myPage/reviewBoard" class="btn btn-light">명소
				후기</a>
		</div>
		<div>
			<table class="table">
				<colgroup>
					<col width="8%" />
					<col width="10%" />
					<col width="55%" />
					<col width="10%" />
					<col width="8%" />
					<col width="8%" />
				</colgroup>
				<thead>
					<tr>
						<th scope="col">No</th>
						<th scope="col">게시판 유형</th>
						<th scope="col">게시글제목</th>
						<th scope="col">작성일자</th>
						<th scope="col">
							<c:choose>
								<c:when test="${param.order!='like'}">
									<a href="post?order=like${searchStr}">좋아요 수 <i
										class="fas fa-caret-down"></i></a>
								</c:when>
								<c:otherwise>
									<a href="post">좋아요 수 <i
										class="fas fa-caret-down order-check"></i></a>
								</c:otherwise>
							</c:choose>
						</th>
						<th scope="col"><c:choose>
								<c:when test="${param.order!='read'}">
									<a href="post?order=read${searchStr}">조회수 <i
										class="fas fa-caret-down"></i></a>
								</c:when>
								<c:otherwise>
									<a href="post">조회수 <i class="fas fa-caret-down order-check"></i></a>
								</c:otherwise>
							</c:choose></th>
					</tr>
				</thead>
				<tbody>
					<c:choose>
						<c:when test="${empty freeBoardList }">

							<!-- 작성한 게시글이 없을 때 -->
							<tr>
								<td class="align-middle" colspan="6">아직 작성한 게시글이 없습니다</td>
							</tr>

						</c:when>
						<c:otherwise>

							<c:forEach items="${freeBoardList }" var="board" varStatus="b">

								<tr>
									<!-- 글번호 -->
									<th class="align-middle" scope="row">${board.freeNo}</th>

									<%-- 카테고리 --%>
									<td class="align-middle">${board.freeCategoryName}</td>

									<!-- 글 제목 -->
									<td class="boardTitle align-middle"><a
										href="${contextPath}/freeboard/${board.freeNo}?cp=${pagination.currentPage}">${board.freeTitle}</a>
										<c:if test="${board.replyCount!=0}">
											<span>[${board.replyCount}]</span>
										</c:if></td>
									<%-- 작성일 --%>
									<td class="align-middle"><fmt:formatDate var="createDate"
											value="${board.freeCreateDate}" pattern="yyyy-MM-dd" /> <fmt:formatDate
											var="today" value="<%=new java.util.Date()%>"
											pattern="yyyy-MM-dd" /> <c:choose>
											<%-- 글 작성일이 오늘이 아닐 경우 --%>
											<c:when test="${createDate != today}">
												${createDate}
											</c:when>

											<%-- 글 작성일이 오늘일 경우 --%>
											<c:otherwise>
												<fmt:formatDate value="${board.freeCreateDate}"
													pattern="HH:mm" />
											</c:otherwise>
										</c:choose></td>

									<!-- 좋아요수 -->
									<td class="align-middle">${board.likeCount}</td>

									<!-- 조회수 -->
									<td class="align-middle">${board.freeReadCount}</td>
								</tr>

							</c:forEach>

						</c:otherwise>

					</c:choose>


				</tbody>
			</table>


			<!---------------------- Pagination start---------------------->
			<!-- 페이징 처리 시 주소를 쉽게 작성할 수 있도록 필요한 변수를 미리 선언 -->


			<c:set var="pageURL" value="post"></c:set>


			<c:set var="prev"
				value="${pageURL}?cp=${pagination.prevPage }${searchStr}${order}"></c:set>
			<!-- 다음페이지 시작주소 -->
			<c:set var="next"
				value="${pageURL}?cp=${pagination.nextPage }${searchStr}${order}"></c:set>

			<div class="my-5">
				<ul class="myPage-pagination">

					<!-- 현재 페이지가 페이지사이즈 초과인 경우 -->
					<c:if test="${pagination.currentPage > pagination.pageSize }">
						<li><a href="${prev }"><i
								class="fas fa-caret-square-left"></i></a></li>
					</c:if>

					<!-- 현재 페이지가 10페이지 초과인 경우 -->
					<c:if test="${pagination.currentPage > pagination.pageSize }">
						<li><a href="${pageURL}?cp=${pagination.currentPage-1}"><i
								class="fas fa-caret-left"></i></a></li>
					</c:if>



					<!-- 페이지 목록 -->
					<c:forEach var="p" begin="${pagination.startPage}"
						end="${pagination.endPage}">

						<c:choose>
							<c:when test="${p == pagination.currentPage }">
								<li><a class="focus-page">${p }</a></li>
							</c:when>
							<c:otherwise>
								<li><a class="focus-page" href="${pageURL}?cp=${p}${searchStr}${order}">${p}</a></li>
							</c:otherwise>
						</c:choose>

					</c:forEach>






					<!-- 현재 페이지가 마지막 페이지 미만인 경우 -->
					<c:if test="${pagination.currentPage < pagination.maxPage }">
						<li><a
							href="${pageURL}?cp=${pagination.currentPage+1}${searchStr}${order}""><i
								class="fas fa-caret-right"></i></a></li>
					</c:if>

					<!-- 현재 페이지가 마지막 페이지 미만인 경우 -->
					<c:if
						test="${pagination.currentPage - pagination.maxPage + pagination.pageSize < 0 }">
						<li><a href="${next}"><i
								class="fas fa-caret-square-right"></i></a></li>
					</c:if>

				</ul>
			</div>
			<!---------------------- Pagination end---------------------->
		</div>
		<!-- 검색창 -->
		<div class="my-5" id="search-container">
			<form action="post" method="GET" class="text-center" id="searchForm"
				onsubmit="return validate();">
				<section class="searchForm-container">
					<select id="formCategory" name="sc" class="custom-select" style="width: 35%;">
						<option value="0">전체</option>
						<option value="1">잡담</option>
						<option value="2">추천</option>
						<option value="3">궁금</option>
						<option value="4">같이</option>
						<option value="5">기타</option>
					</select> 
					<select name="sk" class="custom-select">
						<option value="title">글제목</option>
						<option value="content">내용</option>
					</select> <input type="text" id="sv" name="sv" class="form-control">
					<button class="btn btn-dark form-control">검색</button>				
				</section>
			</form>
		</div>

	</main>
	<script>
		// 검색 내용이 있을 경우 검색창에 해당 내용을 작성해두는 기능
		(function() {
			var searchCategory = "${param.sc}";
			var searchKey = "${param.sk}";
			var searchValue = "${param.sv}";

			// 검색창 select의 option을 반복 접근
			$("select[name=sc] > option").each(function(index, item) {
				// index : 현재 접근중인 요소의 인덱스
				// item : 현재 접근중인 요소
				// content            content
				if ($(item).val() == searchCategory) {
					$(item).prop("selected", true);
				}
			});

			$("select[name=sk] > option").each(function(index, item) {
				// index : 현재 접근중인 요소의 인덱스
				// item : 현재 접근중인 요소
				// content            content
				if ($(item).val() == searchKey) {
					$(item).prop("selected", true);
				}
			});

			// 검색어 입력창에 searcValue 값 출력
			$("input[name=sv]").val(searchValue);

		})();

		function validate() {

			const sv = $("#sv").val().trim();
			if (sv == "") {
				swal("검색 실패", "검색 내용를 입력해주세요.", "error");
				return false;
			}
		}
	</script>
</body>
</html>