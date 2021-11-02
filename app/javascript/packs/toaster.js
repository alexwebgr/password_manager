import { Toast } from "bootstrap";

export default class Toaster {
    static toast(data) {
        const toastContainer = $('.toast-container');
        const toasterSource = $('#toasterSource');
        let toast = toasterSource.find('.onPostLight');

        if(data.status > 199 && data.status < 299) {
            toast = toasterSource.find('.onPostSuccess');
        }

        if(data.status > 399) {
            toast = toasterSource.find('.onPostError');
        }

        let clone = toast.clone();

        clone.find('.toast-body').text(data.message);
        clone.appendTo(toastContainer);

        new Toast(clone[0]).show();
    }
}