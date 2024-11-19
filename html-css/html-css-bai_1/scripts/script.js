document.addEventListener('DOMContentLoaded', function () {
    var toggle = document.getElementById('toggle');
    var mobileMenu = document.getElementById('mobileMenu');

    mobileMenu.style.display = 'block';
    if (window.innerWidth >= 768) {
        mobileMenu.style.display = 'block';
        toggle.classList.remove('active');
    }

    toggle.addEventListener('click', function () {
        if (window.innerWidth <= 768) {
            if (mobileMenu.style.display === 'none') {
                mobileMenu.style.display = 'block';
                toggle.classList.add('active');
            } else {
                mobileMenu.style.display = 'none';
                toggle.classList.remove('active');
            }
        }
    });

    window.addEventListener('resize', function () {
        if (window.innerWidth > 768) {
            mobileMenu.style.display = 'block';
            toggle.classList.remove('active');
        } else {
            mobileMenu.style.display = 'none';
        }
    });

    const tabs = document.querySelectorAll('#tabset_tabs li');
    const tabContents = document.querySelectorAll('.tab-content');

    tabs.forEach(tab => {
        tab.addEventListener('click', function (event) {
            event.preventDefault();
            tabs.forEach(t => t.classList.remove('selected'));
            tab.classList.add('selected');
            tabContents.forEach(content => content.classList.remove('active'));
            const target = tab.querySelector('a').getAttribute('href');
            document.querySelector(target).classList.add('active');
        });
    });

    const dropdowns = document.querySelectorAll('.dropdown');

    document.addEventListener('click', function (event) {
        dropdowns.forEach(function (dropdown) {
            if (!dropdown.contains(event.target) && dropdown.classList.contains('open')) {
                closeDropdown(dropdown);
            }
        });
    });

    function openDropdown(dropdown) {
        dropdown.classList.add('open');
        const menuItem = dropdown.querySelector('.menu-item');
        menuItem.classList.add('active');
        dropdown.querySelector('.dropdown-content').style.display = 'block'; // Show dropdown
    }

    function closeDropdown(dropdown) {
        dropdown.classList.remove('open');
        const menuItem = dropdown.querySelector('.menu-item');
        menuItem.classList.remove('active');
        dropdown.querySelector('.dropdown-content').style.display = 'none'; // Hide dropdown
    }

    function updateMenu() {
        const isMobile = window.innerWidth <= 768;

        document.querySelectorAll('.menu-item').forEach(item => {
            const originalText = item.childNodes[0].textContent.trim();
            item.childNodes[0].textContent = isMobile
                ? originalText.charAt(0).toUpperCase() + originalText.slice(1).toLowerCase()
                : originalText;
        });

        dropdowns.forEach(dropdown => {
            const arrowMobile = dropdown.querySelector('.arrow-mobile');
            const arrowDesktop = dropdown.querySelector('.arrow-desktop');
            arrowDesktop.style.display = isMobile ? 'none' : 'inline-block';
            arrowMobile.style.display = isMobile ? 'inline' : 'none';
        });
    }

    updateMenu();
    window.addEventListener('resize', updateMenu);

    const menuWrapper = document.querySelector('.menu-wrapper');
    const menuItems = document.querySelectorAll('.menu-item');
    const logo = document.querySelector('.logo img');
    const searchIcons = document.querySelectorAll('.search-bar .icons img');

    function adjustSizes() {
        const width = menuWrapper.offsetWidth;
        const newFontSize = Math.max(2, Math.min(width / 30, 20));
        const newLogoSize = Math.max(20, Math.min(width / 15, 100));
        const newIconSize = Math.max(10, Math.min(width / 40, 30));

        menuItems.forEach(item => {
            item.style.fontSize = `${newFontSize}px`;
        });

        logo.style.width = `${newLogoSize}px`;
        searchIcons.forEach(icon => {
            icon.style.width = `${newIconSize}px`;
        });
    }

    window.addEventListener('resize', adjustSizes);
    adjustSizes();

    dropdowns.forEach(dropdown => {
        const menuItem = dropdown.querySelector('.menu-item');

        menuItem.addEventListener('mouseenter', () => {
            openDropdown(dropdown);
        });

        menuItem.addEventListener('mouseleave', () => {
            closeDropdown(dropdown);
        });
    });



    document.addEventListener('DOMContentLoaded', function () {
        const dropdowns = document.querySelectorAll('.dropdown');
    
        dropdowns.forEach(dropdown => {
            const menuItem = dropdown.querySelector('.menu-item');
    
            menuItem.addEventListener('mouseenter', () => {
                const dropdownContent = dropdown.querySelector('.dropdown-content');
                dropdownContent.classList.add('show');
            });
    
            menuItem.addEventListener('mouseleave', () => {
                const dropdownContent = dropdown.querySelector('.dropdown-content');
                dropdownContent.classList.remove('show');
            });
    
            // Close dropdown when clicking outside
            document.addEventListener('click', function (event) {
                if (!dropdown.contains(event.target)) {
                    dropdown.querySelector('.dropdown-content').classList.remove('show');
                }
            });
        });
    });


    
});


