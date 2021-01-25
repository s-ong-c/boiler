# Project(React)


## envioment
- [TypeScript 4.0.x version](https://github.com/microsoft/TypeScript)
- [craco](https://github.com/gsoft-inc/craco)
- [styled-components](https://github.com/emotion-js/emotion)
- [react-router-dom 5.2.x version](https://github.com/ReactTraining/react-router)
- [redux-toolkit 1.5.x](https://github.com/reduxjs/redux-toolkit)
- [react-redux 7.2.x](https://github.com/reduxjs/react-redux)
- [redux-saga 1.1.x](https://github.com/redux-saga/redux-saga)

## structure
```
├──src
    ├── components // Just component with styling
    ├── contaienrs // home, post layout
    ├── lib
    │    ├── styles
    │    │    ├── media
    │    │    ├── palette
    │    │    ├── responsive.ts
    │    │    ├── transitions.ts
    │    │    ├── utils.ts
    │    │    ├── zIndexes.ts
    │    ├── utils 
    │    └── hooks (custom hook)
    ├── pages // routing except post: /(home), /about
    ├── store
        ├── index.ts  // 상태관리
    │     └── blog-post.tsx
    ├── App.tsx
    ├── GlobalStyles // 공통 베이스 styles
    └── index.tsx
├──.env  //environment 파일
├──.gitignore
├──.prettierrc //  컨벤션
├──craco.config.js  // webpack 기능 구현 추가 가능 // without eject
├──package.json // 의존성
├──tsconfig.json // ts setup
├──tsconfig.paths.json
```