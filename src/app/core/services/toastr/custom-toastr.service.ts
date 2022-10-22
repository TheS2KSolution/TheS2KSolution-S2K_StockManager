import { Injectable } from '@angular/core';
import { ToastrService } from 'ngx-toastr';

@Injectable({
  providedIn: 'root'
})
export class CustomToastrService {

  constructor(private toastr: ToastrService) { }

  showSuccessMessage(message: string) {
    this.toastr.success(message);
  }

  showWarningMessage(message: string) {
    this.toastr.warning(message);
  }

  showErrorMessage(message: string) {
    this.toastr.error(message);
  }
}
