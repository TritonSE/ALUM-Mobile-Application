"use client";

import React from 'react'
import styles from '@/styles/Sidebar.module.css'
import Image from 'next/image';
import { usePathname } from 'next/navigation';
import { ALUMLogoIcon, SidebarLogoutIcon, SidebarMenteesIcon, SidebarMentorsIcon, SidebarSessionsIcon } from '@/icons';
import {getAuth} from "firebase/auth";
import {initializeFirebase } from "../../backend/firebase"


type TabInfoType = {
    path: string,
    title: string,
    icon: React.FC<{className?: string}>,
}
const app = initializeFirebase();
const auth = getAuth();
const routes: TabInfoType[] = [
    {
        path: '/mentors',
        title: 'Mentors',
        icon: SidebarMentorsIcon
    },
    {
        path: '/mentees',
        title: 'Mentees',
        icon: SidebarMenteesIcon
    },
    {
        path: '/sessions',
        title: 'Sessions',
        icon: SidebarSessionsIcon
    }
];

type SideBarTabProp = TabInfoType & {isActive: Boolean};

function SideBarTab({path, title, icon: Icon, isActive}: SideBarTabProp) {
    return (
        <div className={`${styles.sidebarTab} ${isActive ? styles.sidebarTabActive : ''}`}>
            <button onClick={() => auth.signOut()} type="button">
                <a href={path}>
                    <Icon />
                    <span className={styles.sidebarTabText}>{title}</span>
                </a>
            </button>
        </div>
    )
}

function LogoutButton() {
    return (
        <div className={styles.sidebarTabContainer}>
            <div className={`${styles.sidebarTab}`}>
                <button onClick={() => auth.signOut() } type="button" className={styles.sidebarTabInnerContainer}>
                    <SidebarLogoutIcon />
                    <span className={styles.sidebarTabText}>Log out</span>
                </button>
            </div>
        </div>
    )
}
export function Sidebar() {
    const currentPath = usePathname()
    return (
        <>
            <div className={styles.sidebarContainer}>
                <div className={styles.sidebarLogoSection}>
                    <ALUMLogoIcon className={styles.alumlogo}/>
                    <span className={styles.sidebarLogoTextContainer}>ALUM</span>
                </div>
                <div className={styles.sidebarTabContainer}>
                    {routes.map((route) => <SideBarTab key={route.path} {...route} isActive={currentPath === route.path}/>)}
                </div>
                <LogoutButton />
            </div>
        </>
    )
}