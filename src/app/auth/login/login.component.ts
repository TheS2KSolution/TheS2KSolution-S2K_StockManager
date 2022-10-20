import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, UntypedFormGroup, Validators } from '@angular/forms';
import { AuthService } from 'src/app/services/auth.service';

const TOKEN_KEY = 'auth-token';
const USER_KEY = 'auth-user';


@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.css']
})
export class LoginComponent implements OnInit {
  public loginForm!: FormGroup;

  constructor(
    private formBuilder: FormBuilder,
    private authService: AuthService) { }

  ngOnInit(): void {
    this.loginForm = this.formBuilder.group({
      usernameOrEmailOrPhone: ['', [Validators.required]],
      password: ['', [Validators.required]]
    });
  }

  loginUser()
  {
  
    this.authService.login(this.loginForm.value.usernameOrEmailOrPhone,
      this.loginForm.value.password).subscribe(
        {
          next:(result)=>{
            console.log(result);
          },
          error:(error)=>{},
        }
      )
    
    
  }

}
