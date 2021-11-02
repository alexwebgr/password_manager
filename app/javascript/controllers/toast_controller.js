import { Controller } from "stimulus";
import Toaster from "../packs/toaster";

export default class extends Controller {
  onPostSuccess(event) {
    const payload = event.detail[0]

    let data = {
      message: payload.message || 'Success!',
      status: event.detail[2].status
    }

    Toaster.toast(data);
  }

  onPostError(event) {
    const payload = event.detail[0]

    let data = {
      message: payload.message,
      status: event.detail[2].status
    }

    Toaster.toast(data);
  }
}
