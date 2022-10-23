import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { Router } from '@angular/router';
import { CompteService } from 'src/app/core/services/compte/compte.service';
import { CustomToastrService } from 'src/app/core/services/toastr/custom-toastr.service';

@Component({
  selector: 'app-register',
  templateUrl: './register.component.html',
  styleUrls: ['./register.component.css']
})
export class RegisterComponent implements OnInit {
  public registerForm!: FormGroup;

  constructor(
    private formBuilder: FormBuilder,
    private compteService: CompteService,
    private toastr: CustomToastrService,
    private router: Router) { }

  ngOnInit(): void {
    this.registerForm = this.formBuilder.group({
      entrepriseName: ['', [Validators.required]],
      numFiscal: ['', [Validators.required]],
      username: ['', [Validators.required]],
      email: ['', [Validators.required, Validators.email]],
      phone: ['', [Validators.required]],
      password: ['', [Validators.required]]
    });
  }

  registerUser(){
    const saveData = {
      "type": "ENTREPRISE",
      "codeFiscal": this.registerForm.value.numFiscal,
      "fullName": this.registerForm.value.entrepriseName,
      "email": this.registerForm.value.email,
      "username": this.registerForm.value.username,
      "password": this.registerForm.value.password,
      "phone": this.registerForm.value.password,
      "roles": [
          {
              "roleId": 2
          }
      ]
    }

    this.compteService.saveNewCompte(saveData).subscribe(
      {
        next: (result) => {
          if(result){
            this.toastr.showSuccessMessage("Inscription valide !");
            this.router.navigate(['/login']);
          }

          if(!result){
            this.toastr.showWarningMessage("Inscription non valide !");
          }
        },
        error: (error) => {
          this.toastr.showWarningMessage("Une erreur est survenue !");
        }
      }
    );
  }

}
