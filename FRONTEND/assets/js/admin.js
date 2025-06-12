
        // Toggle between user and facility fields in add account form
        document.getElementById('accountType').addEventListener('change', function() {
            const accountType = this.value;
            const userFields = document.getElementById('userFields');
            const facilityFields = document.getElementById('facilityFields');
            
            if (accountType === 'user') {
                userFields.style.display = 'block';
                facilityFields.style.display = 'none';
            } else if (accountType === 'facility') {
                userFields.style.display = 'none';
                facilityFields.style.display = 'block';
            } else {
                userFields.style.display = 'none';
                facilityFields.style.display = 'none';
            }
        });

        // Generate unique ID for new accounts
        function generateId(type) {
            const prefix = type === 'user' ? 'US' : 'CSTN';
            const randomNum = Math.floor(100000 + Math.random() * 900000);
            return `${prefix}${randomNum}`;
        }

        // Role mapping for display
        const roleMap = {
            'VT0000001': 'Admin',
            'VT0000002': 'Bác sĩ',
            'VT0000003': 'Nhân viên',
            'VT0000004': 'Người hiến máu',
            'VT0000005': 'Giám đốc ngân hàng máu'
        };

        // Handle add account form submission
        document.getElementById('saveNewAccount').addEventListener('click', function() {
            const accountType = document.getElementById('accountType').value;
            const role = document.getElementById('role').value;
            const activeStatus = document.getElementById('activeStatus').checked;

            if (accountType === 'user') {
                const fullName = document.getElementById('fullName').value;
                const email = document.getElementById('email').value;
                const password = document.getElementById('password').value;
                const confirmPassword = document.getElementById('confirmPassword').value;
                const phone = document.getElementById('phone').value;

                if (!fullName || !email || !password || !confirmPassword || !role) {
                    alert('Vui lòng điền đầy đủ các trường bắt buộc.');
                    return;
                }

                if (password !== confirmPassword) {
                    alert('Mật khẩu và xác nhận mật khẩu không khớp.');
                    return;
                }

                const newId = generateId('user');
                const tableBody = document.getElementById('usersTableBody');
                const newRow = document.createElement('tr');
                newRow.setAttribute('data-account-id', newId);
                newRow.innerHTML = `
                    <td>${newId}</td>
                    <td><img src="default.jpg" alt="Avatar" class="avatar-sm"></td>
                    <td>${fullName}</td>
                    <td>${email}</td>
                    <td>${roleMap[role]}</td>
                    <td>${phone || '-'}</td>
                    <td><span class="account-status ${activeStatus ? 'account-status-active' : 'account-status-inactive'}">${activeStatus ? 'Hoạt động' : 'Không hoạt động'}</span></td>
                    <td>
                        <div class="form-check form-switch d-inline-block">
                            <input class="form-check-input account-status-toggle" type="checkbox" 
                                data-account-id="${newId}" 
                                data-account-type="user" 
                                ${activeStatus ? 'checked' : ''}>
                        </div>
                        <button class="btn btn-sm btn-outline-primary ms-2 edit-account-btn" title="Sửa" data-bs-toggle="modal" data-bs-target="#editAccountModal">
                            <i class="bi bi-pencil"></i>
                        </button>
                    </td>
                `;
                tableBody.appendChild(newRow);
            } else if (accountType === 'facility') {
                const facilityName = document.getElementById('facilityName').value;
                const facilityEmail = document.getElementById('facilityEmail').value;
                const managerName = document.getElementById('managerName').value;
                const facilityPhone = document.getElementById('facilityPhone').value;
                const facilityPassword = document.getElementById('facilityPassword').value;
                const facilityConfirmPassword = document.getElementById('facilityConfirmPassword').value;

                if (!facilityName || !facilityEmail || !managerName || !facilityPassword || !facilityConfirmPassword) {
                    alert('Vui lòng điền đầy đủ các trường bắt buộc.');
                    return;
                }

                if (facilityPassword !== facilityConfirmPassword) {
                    alert('Mật khẩu và xác nhận mật khẩu không khớp.');
                    return;
                }

                const newId = generateId('facility');
                const tableBody = document.getElementById('facilitiesTableBody');
                const newRow = document.createElement('tr');
                newRow.setAttribute('data-account-id', newId);
                newRow.innerHTML = `
                    <td>${newId}</td>
                    <td><img src="default.jpg" alt="Avatar" class="avatar-sm"></td>
                    <td>${facilityName}</td>
                    <td>${facilityEmail}</td>
                    <td>${managerName}</td>
                    <td>${facilityPhone || '-'}</td>
                    <td><span class="account-status ${activeStatus ? 'account-status-active' : 'account-status-inactive'}">${activeStatus ? 'Hoạt động' : 'Không hoạt động'}</span></td>
                    <td>
                        <div class="form-check form-switch d-inline-block">
                            <input class="form-check-input account-status-toggle" type="checkbox" 
                                data-account-id="${newId}" 
                                data-account-type="facility" 
                                ${activeStatus ? 'checked' : ''}>
                        </div>
                        <button class="btn btn-sm btn-outline-primary ms-2 edit-account-btn" title="Sửa" data-bs-toggle="modal" data-bs-target="#editAccountModal">
                            <i class="bi bi-pencil"></i>
                        </button>
                    </td>
                `;
                tableBody.appendChild(newRow);
            }

            // Show toast notification
            const toast = new bootstrap.Toast(document.getElementById('statusChangeToast'));
            document.getElementById('toastMessage').textContent = 'Tài khoản đã được thêm thành công';
            toast.show();

            // Reset form and close modal
            document.getElementById('addAccountForm').reset();
            document.getElementById('userFields').style.display = 'none';
            document.getElementById('facilityFields').style.display = 'none';
            const addModal = bootstrap.Modal.getInstance(document.getElementById('addAccountModal'));
            addModal.hide();
        });

        // Handle edit account button click
        document.addEventListener('click', function(e) {
            if (e.target.closest('.edit-account-btn')) {
                const row = e.target.closest('tr');
                const accountId = row.getAttribute('data-account-id');
                const accountType = row.querySelector('.account-status-toggle').getAttribute('data-account-type');
                const editModal = new bootstrap.Modal(document.getElementById('editAccountModal'));

                document.getElementById('editAccountId').value = accountId;
                document.getElementById('editAccountType').value = accountType;

                if (accountType === 'user') {
                    document.getElementById('editUserFields').style.display = 'block';
                    document.getElementById('editFacilityFields').style.display = 'none';
                    document.getElementById('editFullName').value = row.children[2].textContent;
                    document.getElementById('editEmail').value = row.children[3].textContent;
                    document.getElementById('editRole').value = Object.keys(roleMap).find(key => roleMap[key] === row.children[4].textContent);
                    document.getElementById('editPhone').value = row.children[5].textContent === '-' ? '' : row.children[5].textContent;
                    document.getElementById('editAvatarPreview').src = row.children[1].querySelector('img').src;
                    document.getElementById('editActiveStatus').checked = row.children[6].querySelector('span').textContent === 'Hoạt động';
                } else {
                    document.getElementById('editUserFields').style.display = 'none';
                    document.getElementById('editFacilityFields').style.display = 'block';
                    document.getElementById('editFacilityName').value = row.children[2].textContent;
                    document.getElementById('editFacilityEmail').value = row.children[3].textContent;
                    document.getElementById('editManagerName').value = row.children[4].textContent;
                    document.getElementById('editFacilityPhone').value = row.children[5].textContent === '-' ? '' : row.children[5].textContent;
                    document.getElementById('editFacilityAvatarPreview').src = row.children[1].querySelector('img').src;
                    document.getElementById('editActiveStatus').checked = row.children[6].querySelector('span').textContent === 'Hoạt động';
                }

                editModal.show();
            }
        });

        // Handle edit account form submission
        document.getElementById('saveEditAccount').addEventListener('click', function() {
            const accountId = document.getElementById('editAccountId').value;
            const accountType = document.getElementById('editAccountType').value;
            const role = document.getElementById('editRole').value;
            const activeStatus = document.getElementById('editActiveStatus').checked;
            const tableBody = accountType === 'user' ? document.getElementById('usersTableBody') : document.getElementById('facilitiesTableBody');
            const row = tableBody.querySelector(`tr[data-account-id="${accountId}"]`);

            if (accountType === 'user') {
                const fullName = document.getElementById('editFullName').value;
                const email = document.getElementById('editEmail').value;
                const phone = document.getElementById('editPhone').value;
                const newPassword = document.getElementById('newPassword').value;
                const confirmNewPassword = document.getElementById('confirmNewPassword').value;

                if (!fullName || !email || !role) {
                    alert('Vui lòng điền đầy đủ các trường bắt buộc.');
                    return;
                }

                if (newPassword && newPassword !== confirmNewPassword) {
                    alert('Mật khẩu mới và xác nhận mật khẩu không khớp.');
                    return;
                }

                row.children[2].textContent = fullName;
                row.children[3].textContent = email;
                row.children[4].textContent = roleMap[role];
                row.children[5].textContent = phone || '-';
                row.children[6].innerHTML = `<span class="account-status ${activeStatus ? 'account-status-active' : 'account-status-inactive'}">${activeStatus ? 'Hoạt động' : 'Không hoạt động'}</span>`;
                row.children[7].querySelector('.account-status-toggle').checked = activeStatus;
            } else {
                const facilityName = document.getElementById('editFacilityName').value;
                const facilityEmail = document.getElementById('editFacilityEmail').value;
                const managerName = document.getElementById('editManagerName').value;
                const facilityPhone = document.getElementById('editFacilityPhone').value;
                const newPassword = document.getElementById('editFacilityNewPassword').value;
                const confirmNewPassword = document.getElementById('editFacilityConfirmNewPassword').value;

                if (!facilityName || !facilityEmail || !managerName) {
                    alert('Vui lòng điền đầy đủ các trường bắt buộc.');
                    return;
                }

                if (newPassword && newPassword !== confirmNewPassword) {
                    alert('Mật khẩu mới và xác nhận mật khẩu không khớp.');
                    return;
                }

                row.children[2].textContent = facilityName;
                row.children[3].textContent = facilityEmail;
                row.children[4].textContent = managerName;
                row.children[5].textContent = facilityPhone || '-';
                row.children[6].innerHTML = `<span class="account-status ${activeStatus ? 'account-status-active' : 'account-status-inactive'}">${activeStatus ? 'Hoạt động' : 'Không hoạt động'}</span>`;
                row.children[7].querySelector('.account-status-toggle').checked = activeStatus;
            }

            // Show toast notification
            const toast = new bootstrap.Toast(document.getElementById('statusChangeToast'));
            document.getElementById('toastMessage').textContent = 'Tài khoản đã được cập nhật thành công';
            toast.show();

            // Reset form and close modal
            document.getElementById('editAccountForm').reset();
            const editModal = bootstrap.Modal.getInstance(document.getElementById('editAccountModal'));
            editModal.hide();
            
        });

        // Handle status toggle
        document.addEventListener('DOMContentLoaded', function() {
            const confirmToggleModal = new bootstrap.Modal(document.getElementById('confirmToggleModal'));
            let currentToggle = null;
            let intendedState = null;
            let currentStatusElement = null;

            document.querySelectorAll('.account-status-toggle').forEach(toggle => {
                toggle.addEventListener('change', function() {
                    const accountId = this.dataset.accountId;
                    const accountType = this.dataset.accountType;
                    const isActive = this.checked;

                    intendedState = isActive;
                    currentToggle = this;
                    currentStatusElement = this.closest('tr').querySelector('.account-status');

                    this.checked = !isActive;

                    const message = isActive 
                        ? "Bạn có chắc chắn muốn mở khóa tài khoản này?" 
                        : "Bạn có chắc chắn muốn khóa tài khoản này?";
                    document.getElementById('confirmMessage').textContent = message;

                    confirmToggleModal.show();
                });
            });

            document.getElementById('confirmToggle').addEventListener('click', function() {
                if (currentToggle && currentStatusElement) {
                    currentToggle.checked = intendedState;

                    if (intendedState) {
                        currentStatusElement.textContent = "Hoạt động";
                        currentStatusElement.classList.remove('account-status-inactive');
                        currentStatusElement.classList.add('account-status-active');
                    } else {
                        currentStatusElement.textContent = "Không hoạt động";
                        currentStatusElement.classList.remove('account-status-active');
                        currentStatusElement.classList.add('account-status-inactive');
                    }

                    const accountId = currentToggle.dataset.accountId;
                    const isActive = intendedState;
                    console.log(`Đã ${isActive ? 'mở khóa' : 'khóa'} tài khoản ${accountId}`);

                    const toast = new bootstrap.Toast(document.getElementById('statusChangeToast'));
                    document.getElementById('toastMessage').textContent = 
                        `Tài khoản đã được ${isActive ? 'mở khóa' : 'khóa'} thành công`;
                    toast.show();
                }

                confirmToggleModal.hide();
            });

            document.querySelector('#confirmToggleModal .btn-secondary').addEventListener('click', function() {
                if (currentToggle) {
                    currentToggle.checked = !intendedState;
                }
                confirmToggleModal.hide();
            });
        });