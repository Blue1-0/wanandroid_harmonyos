import Fetch from "@system.fetch";


export default class NetUtils {



  static doPost(
    url: string,
    data: string,
    onSuccess: (data: string | object) => void,
    onFailed: (code: number, data: string | object) => void
  ): void {

    Fetch.fetch({
      url: url,
      method: 'POST',
      header: {
        'Content-Type': "application/json"
      },
      responseType: 'JSON',
      data: data,
      success: (result) => {
        if (result.code === 200) {
          onSuccess(result.data);
          if (typeof result.data === 'string') {
            console.log("===doPost:success===" + url + "\ndata: " + result.data);
          } else {
            console.log("===doPost:success===" + url + "\ndata: " + (JSON.stringify(result.data)));
          }

        } else {
          onFailed(result.code, result.data)
          if (typeof result.data === "string") {
            console.log("===doPost:failed===" + url + "\tcode: " + result.code + "data:" + result.data);
          } else {
            console.log("===doPost:failed===" + url + "\tcode: " + result.code + "data:" +
              (JSON.stringify(result.data)));
          }

        }
      },
      fail: (data: object, code: number) => {
        onFailed(code, data)
        console.log("===doPost:failed===" + url + "\tcode: " + code + "data:" + (JSON.stringify(data)));
      },
      complete: () => {
        console.log("===doPost===" + url + "\ndata: " + data);
      }
    })

  }
}