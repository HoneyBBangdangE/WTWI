package com.wtwi.fin.member.model.service;

import java.util.List;

import com.wtwi.fin.freeboard.model.vo.Board;
import com.wtwi.fin.member.model.vo.Pagination;
import com.wtwi.fin.member.model.vo.Search;
import com.wtwi.fin.qnaboard.model.vo.QnaBoard;
import com.wtwi.fin.member.model.vo.Member;

public interface MypageService {
	


	/** 내가 쓴 글(자유게시판) 페이징 처리
	 * @param loginMember
	 * @param pg
	 * @return
	 */
	Pagination getFreePagination(Member member, Pagination pg);

	/** 내가 쓴 글(자유게시판) 전체 게시글 목록
	 * @param pagination
	 * @return
	 */
	List<Board> selectFreeBoardList(Pagination pagination);

	/** 내가 쓴 글(자유게시판) 전체 게시글 수 조회(검색)
	 * @param search
	 * @param pg
	 * @return
	 */
	Pagination getFreePagination(Search search, Pagination pg);

	/** 내가 쓴 글(자유게시판) 전체 게시글 목록(검색)
	 * @param search
	 * @param pagination
	 * @return
	 */
	List<Board> selectSearchFreeBoardList(Search search, Pagination pagination);

	/** 내가 쓴 글(문의게시판) 페이징 처리
	 * @param memberNo
	 * @param pg
	 * @return
	 */
	Pagination getQnAPagination(Member member, Pagination pg);

	/**  내가 쓴 글(문의게시판) 전체 게시글 목록
	 * @param pagination
	 * @return
	 */
	List<QnaBoard> selectQnABoardList(Pagination pagination);

	/** 내가 쓴 글(자유게시판) 전체 게시글 수 조회(검색)
	 * @param search
	 * @param pg
	 * @return
	 */
	Pagination getQnAPagination(Search search, Pagination pg);

	/** 내가 쓴 글(문의게시판) 전체 게시글 목록(검색)
	 * @param search
	 * @param pagination
	 * @return
	 */
	List<QnaBoard> selectSearchQnABoardList(Search search, Pagination pagination);

}
