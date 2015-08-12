package im.actor.core.api;
/*
 *  Generated by the Actor API Scheme generator.  DO NOT EDIT!
 */

import im.actor.runtime.bser.*;
import im.actor.runtime.collections.*;

import org.jetbrains.annotations.Nullable;

import java.io.IOException;

public class ServiceExChangedAvatar extends ServiceEx {

    private Avatar avatar;

    public ServiceExChangedAvatar(@Nullable Avatar avatar) {
        this.avatar = avatar;
    }

    public ServiceExChangedAvatar() {

    }

    public int getHeader() {
        return 6;
    }

    @Nullable
    public Avatar getAvatar() {
        return this.avatar;
    }

    @Override
    public void parse(BserValues values) throws IOException {
        this.avatar = values.optObj(1, new Avatar());
        if (values.hasRemaining()) {
            setUnmappedObjects(values.buildRemaining());
        }
    }

    @Override
    public void serialize(BserWriter writer) throws IOException {
        if (this.avatar != null) {
            writer.writeObject(1, this.avatar);
        }
        if (this.getUnmappedObjects() != null) {
            SparseArray<Object> unmapped = this.getUnmappedObjects();
            for (int i = 0; i < unmapped.size(); i++) {
                int key = unmapped.keyAt(i);
                writer.writeUnmapped(key, unmapped.get(key));
            }
        }
    }

    @Override
    public String toString() {
        String res = "struct ServiceExChangedAvatar{";
        res += "avatar=" + (this.avatar != null ? "set":"empty");
        res += "}";
        return res;
    }

}