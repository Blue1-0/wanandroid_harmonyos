// 定义响应数据的类型
export interface ResponseData<T> {
  data: T;
  errorCode: number;
  errorMsg: string;
}

//banner
export interface BannerBean {
  //"desc":"我们支持订阅啦~",
  // "id":30,
  // "imagePath":"https://www.wanandroid.com/blogimgs/42da12d8-de56-4439-b40c-eab66c227a4b.png",
  // "isVisible":1,
  // "order":2,
  // "title":"我们支持订阅啦~",
  // "type":0,
  // "url":"https://www.wanandroid.com/blog/show/3352"
  desc: string
  id: string
  imagePath: string
  isVisible: string
  order: string
  title: string
  type: string
  url: string
}

//article

export interface ArticleEntity {
  curPage: number;
  datas: ArticleEntityDatas[];
  offset: number;
  over: boolean;
  pageCount: number;
  size: number;
  total: number;
}

export interface ArticleEntityDatas {
  adminAdd: boolean;
  apkLink: string;
  audit: number;
  author: string;
  canEdit: boolean;
  chapterId: number;
  chapterName: string;
  collect: boolean;
  courseId: number;
  desc: string;
  descMd: string;
  envelopePic: string;
  fresh: boolean;
  host: string;
  id: number;
  isAdminAdd: boolean;
  link: string;
  niceDate: string;
  niceShareDate: string;
  origin: string;
  prefix: string;
  projectLink: string;
  publishTime: number;
  realSuperChapterId: number;
  selfVisible: number;
  shareDate: number;
  shareUser: string;
  superChapterId: number;
  superChapterName: string;

  // List<dynamic>? tags;
  title: string;
  type: number;
  userId: number;
  visible: number;
  zan: number;

}


export interface ProjectTreeEntity {
  articleList: object[];
  author: string;
  children: object[];
  courseId: string;
  cover: string;
  desc: string;
  id: number;
  lisense: string;
  lisenseLink: string;
  name: string;
  order: number;
  parentChapterId: number;
  type: number;
  userControlSetTop: boolean;
  visible: number;
}